-- script creacion tablas

BEGIN;


CREATE TABLE IF NOT EXISTS public.clientes
(
    id_cliente integer NOT NULL,
    nombre character varying(30),
    direccion character varying(30),
    correo_electronico character varying(30),
    PRIMARY KEY (id_cliente)
);

CREATE TABLE IF NOT EXISTS public.libros
(
    id_libro integer,
    titulo character varying(30),
    autor character varying(30),
    genero character varying(30),
    descripcion character varying(50),
    precio integer,
    fecha_publicacion date,
    PRIMARY KEY (id_libro)
);

CREATE TABLE IF NOT EXISTS public.pedidos
(
    id_pedido integer,
    id_libro integer,
    fecha_pedido date,
    PRIMARY KEY (id_pedido)
);

CREATE TABLE IF NOT EXISTS public.inventario
(
    id_inventario integer,
    id_libro integer,
    cantidad_inventario integer,
    PRIMARY KEY (id_inventario)
);

CREATE TABLE IF NOT EXISTS public.detalle_pedido
(
    id_detalle_pedido integer,
    id_pedido integer,
    id_cliente integer,
    cantidad_comprada integer,
    PRIMARY KEY (id_detalle_pedido)
);

ALTER TABLE IF EXISTS public.pedidos
    ADD CONSTRAINT fk_id_libro FOREIGN KEY (id_libro)
    REFERENCES public.libros (id_libro) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.inventario
    ADD CONSTRAINT fk_id_libro FOREIGN KEY (id_libro)
    REFERENCES public.libros (id_libro) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.detalle_pedido
    ADD CONSTRAINT fk_id_cliente FOREIGN KEY (id_cliente)
    REFERENCES public.clientes (id_cliente) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.detalle_pedido
    ADD CONSTRAINT fk_id_pedido FOREIGN KEY (id_pedido)
    REFERENCES public.pedidos (id_pedido) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;

END;

-- insert tabla clientes

INSERT INTO public.clientes(
	id_cliente, nombre, direccion, correo_electronico)
	VALUES (1,'Cristian Machado' , 'calle 38 #53a', 'cmachado@gmail.com');
INSERT INTO public.clientes(
	id_cliente, nombre, direccion, correo_electronico)
	VALUES (2,'Daniel Martinez' , 'calle 39 #12 sur', 'dmartinez@gmail.com');
INSERT INTO public.clientes(
	id_cliente, nombre, direccion, correo_electronico)
	VALUES (3,'Didier Toro' , 'calle 37 #63c', 'dtoro@gmail.com');
INSERT INTO public.clientes(
	id_cliente, nombre, direccion, correo_electronico)
	VALUES (4,'Felipe Machado' , 'calle 36 #59', 'fmachado@gmail.com');
INSERT INTO public.clientes(
	id_cliente, nombre, direccion, correo_electronico)
	VALUES (5,'Miguel Parada' , 'calle 30 #22', 'mparada@gmail.com');

--insert tabla libros

INSERT INTO public.libros(
	id_libro, titulo, autor, genero, descripcion, precio, fecha_publicacion)
	VALUES (101, 'Romeo y Julieta', 'William Shakespeare', 'Tragedia', 'Descripcion Romeo y Julieta', 20000, '1595-01-29');
INSERT INTO public.libros(
	id_libro, titulo, autor, genero, descripcion, precio, fecha_publicacion)
	VALUES (102, 'Don Quijote de la Mancha', 'Miguel de Cervantes', 'Novela, Parodia, Sátira, Farsa', 'Descripcion Don Quijote de la Mancha',30000, '1605-01-16');
INSERT INTO public.libros(
	id_libro, titulo, autor, genero, descripcion, precio, fecha_publicacion)
	VALUES (103, 'El Señor de los Anillos', 'J. R. R. Tolkien', 'Literatura fantástica, Alta fantasía, Ficción de aventuras', 'Descripcion señor de los anillos', 25000, '1954-07-29');
INSERT INTO public.libros(
	id_libro, titulo, autor, genero, descripcion, precio, fecha_publicacion)
	VALUES (104, 'El principito', 'Antoine de Saint-Exupéry', 'Tragedia', 'Descripcion El principito' , 50000, '1943-04-1943');

--insert tabla inventario

INSERT INTO public.inventario(
	id_inventario, id_libro, cantidad_inventario)
	VALUES (1, 101, 20);
INSERT INTO public.inventario(
	id_inventario, id_libro, cantidad_inventario)
	VALUES (2, 102, 25);
INSERT INTO public.inventario(
	id_inventario, id_libro, cantidad_inventario)
	VALUES (3, 103, 22);
INSERT INTO public.inventario(
	id_inventario, id_libro, cantidad_inventario)
	VALUES (4, 104, 30);


--insert tabla pedidos

INSERT INTO public.pedidos(
	id_pedido, id_libro, fecha_pedido)
	VALUES (1, 101, '2023-04-10');
INSERT INTO public.pedidos(
	id_pedido, id_libro, fecha_pedido)
	VALUES (2, 102, '2023-02-12');
INSERT INTO public.pedidos(
	id_pedido, id_libro, fecha_pedido)
	VALUES (3, 102, '2023-04-11');
INSERT INTO public.pedidos(
	id_pedido, id_libro, fecha_pedido)
	VALUES (4, 103, '2023-04-12');
INSERT INTO public.pedidos(
	id_pedido, id_libro, fecha_pedido)
	VALUES (5, 101, '2023-05-10');

--insert detalle_pedido

INSERT INTO public.detalle_pedido(
	id_detalle_pedido, id_pedido, id_cliente, cantidad_comprada)
	VALUES (1, 1, 2, 5);
INSERT INTO public.detalle_pedido(
	id_detalle_pedido, id_pedido, id_cliente, cantidad_comprada)
	VALUES (2, 2, 2, 7);
INSERT INTO public.detalle_pedido(
	id_detalle_pedido, id_pedido, id_cliente, cantidad_comprada)
	VALUES (3, 3, 2, 2);
INSERT INTO public.detalle_pedido(
	id_detalle_pedido, id_pedido, id_cliente, cantidad_comprada)
	VALUES (4, 4, 2, 1);

--consulta 1

select l.titulo, sum(dp.cantidad_comprada) as total_vendido, fecha_pedido
from libros l
inner join detalle_pedido dp on l.id_libro = dp.id_libro
inner join pedidos pe on dp.id_pedido = pe.id_pedido
where pe.fecha_pedido > '2023-04-01' and pe.fecha_pedido < '2023-04-30'
group by l.titulo, pe.fecha_pedido
order by total_vendido desc
limit 1

--consulta 2

select avg(precio) as promedio_precio_libro 
from libros

--challenge
--creacion tabla para almacenar todos los datos
CREATE TABLE public.valor_iva_total
(
    id_pedido integer,
    valor_iva integer,
    valor_total integer
);

ALTER TABLE IF EXISTS public.valor_iva_total
    OWNER to postgres;

--procedure

create procedure calcular_valor_iva_total(id_pedido integer)
as
$$
declare
subtotal numeric;
total numeric;
iva numeric;
begin
select sum (dp.cantidad_comprada * l.precio) into subtotal
from detalle_pedido dp
join libros l on dp.id_libro = l.id_libro
where dp.id_pedido = calcular_valor_iva_total.id_pedido;

	if subtotal is null then raise exception 'la orden de compra no tiene un libro asociado';
	end if;
	
	iva:= subtotal * 0.2;
	total:= subtotal + iva;
	
insert into valor_iva_total(id_pedido, valor_iva, valor_total)
values (id_pedido, iva, total);
end
$$
language plpgsql

--ejemplo de select funcional

call calcular_valor_iva_total(3)

--ejemplo de select no funcional

call calcular_valor_iva_total(7)