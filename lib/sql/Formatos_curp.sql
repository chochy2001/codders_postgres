create or replace function formato_curp() returns trigger
    language plpgsql
as
$$
    declare
    cadenaCurp char(18);
    c char;
begin
    cadenaCurp = new.curp;
    if char_length(new.curp) is null or char_length(new.curp) != 18 then
        raise exception 'curp invalido';
        end if;
        for i in 1.. 18 loop
            c = substring(cadenaCurp, i, 1);
            --raise notice 'posicion % Caracter % ', i, c;
             if (i <= 4  and c !~* '[a-z]')
                    then
                        raise EXCEPTION 'caracteres invalidos en las primeras 4 posiciones';
                        exit;
                elsif (i>4 and i <= 10 and c !~* '[0-9]')
                    then
                        raise exception 'los caracteres que corresponden a la fecha son incorrectos';
                        exit ;
                elsif (i=11 and c !~* '[h|m]')
                    then
                        raise exception 'caracter referente a sexo invalido';
                        exit ;
                elsif (i > 11 and i <= 16 and c !~* '[a-z]')
                    then
                        raise exception 'error en entidad federativa o caracteres subsecuentes';
                        exit ;
                elsif (i > 16 and i <= 18 and c !~* '[a-z0-9]')
                    then
                        raise exception 'ultimos 2 caracteres invalidos';
                        exit ;
                end if;
        end loop;
    if (tg_op = 'UPDATE') then
        raise notice 'Cambiando curp % a nuevo curp %', old.curp, new.curp;
    end if;
    return new;
end
$$;

create function formato_rfc() returns trigger
    language plpgsql
as
$$
    declare
    cadenaRfc char(13);
    c char;
begin
    cadenaRfc = new.rfc;
    if char_length(new.rfc) is null or char_length(new.rfc) != 13 then
        raise exception 'rfc invalido';
        end if;
        for i in 1.. 13 loop
            c = substring(cadenaRfc, i, 1);
            --raise notice 'posicion % Caracter % ', i, c;
             if (i <= 4  and c !~* '[a-z]')
                    then
                        raise EXCEPTION 'caracteres invalidos en las primeras 4 posiciones';
                        exit;
                elsif (i>4 and i <= 10 and c !~* '[0-9]')
                    then
                        raise exception 'los caracteres que corresponden a la fecha son incorrectos';
                        exit ;
                elsif (i > 10 and i <= 13 and c !~* '[a-z0-9]')
                    then
                        raise exception 'homoclave invalida';
                        exit ;
                end if;
        end loop;
    if (tg_op = 'UPDATE') then
        raise notice 'Cambiando rfc % a nuevo rfc %', old.rfc, new.rfc;
    end if;
    return new;
end
$$;

create trigger verifica_rfcempleado
    before insert or update
    on empleado
    for each row
execute procedure formato_rfc();

create trigger verifica_curpcempleado
    before insert or update
    on empleado
    for each row
execute procedure formato_curp();

create trigger verifica_rfccliente
    before insert or update
    on cliente
    for each row
execute procedure formato_rfc();