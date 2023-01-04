--NOTA DE VENTAS_SUCURSAL_* : count(*) -> numero de ventas por sucursal
--							  sum(v.monto_total) -> total por sucursal

create or replace function ventas_sucursal_if(
	p_fecha_inicial date,
	p_fecha_final	date
) returns varchar
as $$

--variables a utilizar
declare v_resultado varchar(10000);

begin
	if(p_fecha_final <= p_fecha_inicial) then
		RAISE NOTICE 'La fecha final no puede ser menor o igual que la fecha inicial';
	else 
		select cast( 
		  (s.id_sucursal,
			count(*),
			sum(v.monto_total)
		  ) as varchar(10000)
		) into v_resultado
		from venta v join empleado e on(v.id_empleado=e.id_empleado)
		join sucursal s on(e.id_sucursal = s.id_sucursal)
		where (fecha >= p_fecha_inicial) and (fecha <= p_fecha_final)
		group by s.id_sucursal;
	end if;
	return v_resultado;
end;
$$ language plpgsql;



create or replace function ventas_sucursal() returns varchar 
as $$

--variables a utilizar
declare v_resultado varchar(10000);

begin
	select cast( 
	  (s.id_sucursal,
		count(*), 
		sum(v.monto_total)
	  ) as varchar(10000)
	) into v_resultado
	from venta v join empleado e on(v.id_empleado=e.id_empleado)
	join sucursal s on(e.id_sucursal = s.id_sucursal)
	where (fecha <= current_date)
	group by s.id_sucursal;

	return v_resultado;
end;
$$ language plpgsql;


create or replace function ventas_sucursal_f(
	p_fecha_final date
) returns varchar
as $$

--variables a utilizar
declare v_resultado varchar(10000);

begin
	select cast( 
	  (s.id_sucursal,
		count(*),
		sum(v.monto_total)
	  ) as varchar(10000)
	) into v_resultado
	from venta v join empleado e on(v.id_empleado=e.id_empleado)
	join sucursal s on(e.id_sucursal = s.id_sucursal)
	where (fecha < p_fecha_final)
	group by s.id_sucursal;
	return v_resultado;
end;
$$ language plpgsql;