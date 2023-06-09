PGDMP         !        
        {            prueba_ohelit    15.2    15.2                0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false                       0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false                        0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            !           1262    24826    prueba_ohelit    DATABASE     �   CREATE DATABASE prueba_ohelit WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Spanish_Spain.1252';
    DROP DATABASE prueba_ohelit;
                postgres    false            �            1255    24936 !   calcular_valor_iva_total(integer) 	   PROCEDURE     W  CREATE PROCEDURE public.calcular_valor_iva_total(IN id_pedido integer)
    LANGUAGE plpgsql
    AS $$
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
$$;
 F   DROP PROCEDURE public.calcular_valor_iva_total(IN id_pedido integer);
       public          postgres    false            �            1259    24880    clientes    TABLE     �   CREATE TABLE public.clientes (
    id_cliente integer NOT NULL,
    nombre character varying(30),
    direccion character varying(30),
    correo_electronico character varying(30)
);
    DROP TABLE public.clientes;
       public         heap    postgres    false            �            1259    24900    detalle_pedido    TABLE     �   CREATE TABLE public.detalle_pedido (
    id_detalle_pedido integer NOT NULL,
    id_pedido integer,
    id_cliente integer,
    cantidad_comprada integer,
    id_libro integer
);
 "   DROP TABLE public.detalle_pedido;
       public         heap    postgres    false            �            1259    24895 
   inventario    TABLE     ~   CREATE TABLE public.inventario (
    id_inventario integer NOT NULL,
    id_libro integer,
    cantidad_inventario integer
);
    DROP TABLE public.inventario;
       public         heap    postgres    false            �            1259    24885    libros    TABLE     �   CREATE TABLE public.libros (
    id_libro integer NOT NULL,
    titulo character varying(30),
    autor character varying(30),
    genero character varying(30),
    descripcion character varying(50),
    precio integer,
    fecha_publicacion date
);
    DROP TABLE public.libros;
       public         heap    postgres    false            �            1259    24890    pedidos    TABLE     m   CREATE TABLE public.pedidos (
    id_pedido integer NOT NULL,
    id_libro integer,
    fecha_pedido date
);
    DROP TABLE public.pedidos;
       public         heap    postgres    false            �            1259    24932    valor_iva_total    TABLE     o   CREATE TABLE public.valor_iva_total (
    id_pedido integer,
    valor_iva integer,
    valor_total integer
);
 #   DROP TABLE public.valor_iva_total;
       public         heap    postgres    false                      0    24880    clientes 
   TABLE DATA           U   COPY public.clientes (id_cliente, nombre, direccion, correo_electronico) FROM stdin;
    public          postgres    false    214   [!                 0    24900    detalle_pedido 
   TABLE DATA           o   COPY public.detalle_pedido (id_detalle_pedido, id_pedido, id_cliente, cantidad_comprada, id_libro) FROM stdin;
    public          postgres    false    218   
"                 0    24895 
   inventario 
   TABLE DATA           R   COPY public.inventario (id_inventario, id_libro, cantidad_inventario) FROM stdin;
    public          postgres    false    217   K"                 0    24885    libros 
   TABLE DATA           i   COPY public.libros (id_libro, titulo, autor, genero, descripcion, precio, fecha_publicacion) FROM stdin;
    public          postgres    false    215   �"                 0    24890    pedidos 
   TABLE DATA           D   COPY public.pedidos (id_pedido, id_libro, fecha_pedido) FROM stdin;
    public          postgres    false    216   �#                 0    24932    valor_iva_total 
   TABLE DATA           L   COPY public.valor_iva_total (id_pedido, valor_iva, valor_total) FROM stdin;
    public          postgres    false    219   �#       z           2606    24884    clientes clientes_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.clientes
    ADD CONSTRAINT clientes_pkey PRIMARY KEY (id_cliente);
 @   ALTER TABLE ONLY public.clientes DROP CONSTRAINT clientes_pkey;
       public            postgres    false    214            �           2606    24904 "   detalle_pedido detalle_pedido_pkey 
   CONSTRAINT     o   ALTER TABLE ONLY public.detalle_pedido
    ADD CONSTRAINT detalle_pedido_pkey PRIMARY KEY (id_detalle_pedido);
 L   ALTER TABLE ONLY public.detalle_pedido DROP CONSTRAINT detalle_pedido_pkey;
       public            postgres    false    218            �           2606    24899    inventario inventario_pkey 
   CONSTRAINT     c   ALTER TABLE ONLY public.inventario
    ADD CONSTRAINT inventario_pkey PRIMARY KEY (id_inventario);
 D   ALTER TABLE ONLY public.inventario DROP CONSTRAINT inventario_pkey;
       public            postgres    false    217            |           2606    24889    libros libros_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.libros
    ADD CONSTRAINT libros_pkey PRIMARY KEY (id_libro);
 <   ALTER TABLE ONLY public.libros DROP CONSTRAINT libros_pkey;
       public            postgres    false    215            ~           2606    24894    pedidos pedidos_pkey 
   CONSTRAINT     Y   ALTER TABLE ONLY public.pedidos
    ADD CONSTRAINT pedidos_pkey PRIMARY KEY (id_pedido);
 >   ALTER TABLE ONLY public.pedidos DROP CONSTRAINT pedidos_pkey;
       public            postgres    false    216            �           2606    24915    detalle_pedido fk_id_cliente    FK CONSTRAINT     �   ALTER TABLE ONLY public.detalle_pedido
    ADD CONSTRAINT fk_id_cliente FOREIGN KEY (id_cliente) REFERENCES public.clientes(id_cliente) NOT VALID;
 F   ALTER TABLE ONLY public.detalle_pedido DROP CONSTRAINT fk_id_cliente;
       public          postgres    false    218    214    3194            �           2606    24905    pedidos fk_id_libro    FK CONSTRAINT     �   ALTER TABLE ONLY public.pedidos
    ADD CONSTRAINT fk_id_libro FOREIGN KEY (id_libro) REFERENCES public.libros(id_libro) NOT VALID;
 =   ALTER TABLE ONLY public.pedidos DROP CONSTRAINT fk_id_libro;
       public          postgres    false    216    3196    215            �           2606    24910    inventario fk_id_libro    FK CONSTRAINT     �   ALTER TABLE ONLY public.inventario
    ADD CONSTRAINT fk_id_libro FOREIGN KEY (id_libro) REFERENCES public.libros(id_libro) NOT VALID;
 @   ALTER TABLE ONLY public.inventario DROP CONSTRAINT fk_id_libro;
       public          postgres    false    217    215    3196            �           2606    24925    detalle_pedido fk_id_libro    FK CONSTRAINT     �   ALTER TABLE ONLY public.detalle_pedido
    ADD CONSTRAINT fk_id_libro FOREIGN KEY (id_libro) REFERENCES public.libros(id_libro) NOT VALID;
 D   ALTER TABLE ONLY public.detalle_pedido DROP CONSTRAINT fk_id_libro;
       public          postgres    false    3196    215    218            �           2606    24920    detalle_pedido fk_id_pedido    FK CONSTRAINT     �   ALTER TABLE ONLY public.detalle_pedido
    ADD CONSTRAINT fk_id_pedido FOREIGN KEY (id_pedido) REFERENCES public.pedidos(id_pedido) NOT VALID;
 E   ALTER TABLE ONLY public.detalle_pedido DROP CONSTRAINT fk_id_pedido;
       public          postgres    false    216    218    3198               �   x�e�1�0F�미�;�VP6����˥�xI��⯷Q1D�w�˽��ǉ�Æ̝l��w��(M`��@�3������OF��s�E�P�
�9���J�P�e�����R�Sb��N���~��U�������95�)��e�A���W�k&�x;(P,         1   x�Ǳ  ��ŉ˰�$�{AHl(��t��B�S���]$��         +   x��1 0����8)����hR�\��&ʥ7��ٌڼ|{t�           x�u�Kj�0�������,^�$]Rh覛��i�H�i��e�|����Z���O��FF�ŮULፕb���Wr�%8Z<Ӊ6�j�M�F���X���B�qD2��|m��x'
�u}A��%5���v�=9x1�%�o?��\NZ�Z[%*꿍��ƉR���8L�hԕI�3�5�?zbGڷ�Bv�A�g[di(��%ӑm,��J��������m�/{��-�e9��*�$��� ~m�/         ;   x�M��	  �w��H���F�wX�Ơ)��P��)d�*�Y����>� p �6�         ,   x�3�42 NC0�e�ibp��(.cNC��X�Um� M]
     