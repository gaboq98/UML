-- Generated by Oracle SQL Developer Data Modeler 18.1.0.082.1035
--   at:        2018-04-09 18:48:35 CST
--   site:      SQL Server 2012
--   type:      SQL Server 2012



CREATE TABLE cliente 
    (
    id_cliente   VARCHAR(6) NOT NULL,
    cedula       NUMERIC(9) NOT NULL,
    nombre       VARCHAR(30) NOT NULL,
    direccion    VARCHAR(30) NOT NULL DEFAULT 'Sin direccion' , 
     ID_REGISTRO VARCHAR (6) NOT NULL , 
     FECHA_REGISTRO DATE NOT NULL , 
     ID_ULT_MOD VARCHAR (6) NOT NULL , 
     FECHA_ULT_MOD DATE NOT NULL 
    )
    ON "default" go

ALTER TABLE CLIENTE ADD constraint pk_cliente PRIMARY KEY CLUSTERED (ID_CLIENTE)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
     ON "default" 
    GO
    ALTER TABLE cliente add constraint uk_clnt_cedula unique nonclustered(cedula)
     ON "default" go

CREATE TABLE cliente_email (
    correo           VARCHAR(30) NOT NULL,
    id_cliente       VARCHAR(6) NOT NULL,
    id_registro      VARCHAR(6) NOT NULL,
    fecha_registro   DATE NOT NULL,
    id_ult_mod       VARCHAR(6) NOT NULL,
    fecha_ult_mod    DATE NOT NULL
)
    ON "default" go

ALTER TABLE CLIENTE_EMAIL ADD constraint cliente_email_pk PRIMARY KEY CLUSTERED (CORREO)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
     ON "default" go

CREATE TABLE cliente_telefono (
    telefono         NUMERIC(8) NOT NULL,
    id_cliente       VARCHAR(6) NOT NULL,
    id_registro      VARCHAR(6) NOT NULL,
    fecha_registro   DATE NOT NULL,
    id_ult_mod       VARCHAR(6) NOT NULL,
    fecha_ult_mod    DATE NOT NULL
)
    ON "default" go

ALTER TABLE CLIENTE_TELEFONO ADD constraint pk_cliente_telefono PRIMARY KEY CLUSTERED (TELEFONO)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
     ON "default" go

CREATE TABLE contrato (
    id_contrato      VARCHAR(6) NOT NULL,
    id_cliente       VARCHAR(6) NOT NULL,
    id_proyecto      VARCHAR(8) NOT NULL,
    plazo_meses      NUMERIC(6) NOT NULL,
    id_registro      VARCHAR(6) NOT NULL,
    fecha_registro   DATE NOT NULL,
    id_ult_mod       VARCHAR(6) NOT NULL,
    fecha_ult_mod    DATE NOT NULL
)
    ON "default" go

ALTER TABLE CONTRATO ADD constraint pk_contrato PRIMARY KEY CLUSTERED (ID_CONTRATO)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
     ON "default" go

CREATE TABLE cuentas_por_cobrar (
    id_contrato      VARCHAR(6) NOT NULL,
    estado           CHAR(1) NOT NULL,
    monto_total      NUMERIC(10) NOT NULL,
    monto_pagado     NUMERIC(10) NOT NULL,
    id_registro      VARCHAR(6) NOT NULL,
    fecha_registro   DATE NOT NULL,
    id_ult_mod       VARCHAR(6) NOT NULL,
    fecha_ult_mod    DATE NOT NULL
)
    ON "default" go

ALTER TABLE CUENTAS_POR_COBRAR ADD constraint cuenta_pk PRIMARY KEY CLUSTERED (ID_CONTRATO)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
     ON "default" 
    GO

ALTER TABLE cuentas_por_cobrar add constraint ck_cnt_estado check(estado = 'P' OR estado = 'C') go

CREATE TABLE empleado (
    id_empleado      VARCHAR(6) NOT NULL,
    cedula           NUMERIC(9) NOT NULL,
    fecha_ingreso    DATE NOT NULL,
    nombre           VARCHAR(20) NOT NULL,
    telefono         NUMERIC(8) NOT NULL,
    direccion        VARCHAR(50) NOT NULL,
    id_registro      VARCHAR(6) NOT NULL,
    fecha_registro   DATE NOT NULL,
    id_ult_mod       VARCHAR(6) NOT NULL,
    fecha_ult_mod    DATE NOT NULL
)
    ON "default" go

ALTER TABLE EMPLEADO ADD constraint pk_empleado PRIMARY KEY CLUSTERED (ID_EMPLEADO)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
     ON "default" 
    GO
    ALTER TABLE EMPLEADO ADD CONSTRAINT UK_CEDULA UNIQUE NONCLUSTERED (CEDULA)
     ON "default" 
    GO

ALTER TABLE EMPLEADO ADD CONSTRAINT CK_EMP_FCH_REGISTRO CHECK ( FECHA_REGISTRO = GETDATE() ) 
GO


ALTER TABLE empleado add constraint ck_emp_fch_ult_mod check(fecha_ult_mod = getdate() ) go

CREATE TABLE empleado_proyecto (
    id_proyecto      VARCHAR(8) NOT NULL,
    id_empleado      VARCHAR(6) NOT NULL,
    salario_hora     NUMERIC(8) NOT NULL,
    id_registro      VARCHAR(6) NOT NULL,
    fecha_registro   DATE NOT NULL,
    id_ult_mod       VARCHAR(6) NOT NULL,
    fecha_ult_mod    DATE NOT NULL
)
    ON "default" go

ALTER TABLE EMPLEADO_PROYECTO ADD constraint pk_emp_pry PRIMARY KEY CLUSTERED (ID_EMPLEADO, ID_PROYECTO)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
     ON "default" go

CREATE TABLE factura (
    id_factura          VARCHAR(6) NOT NULL,
    id_proveedor        VARCHAR(6) NOT NULL,
    id_proyecto         VARCHAR(8) NOT NULL,
    monto_total         NUMERIC(10) NOT NULL,
    saldo_pendiente     NUMERIC(10) NOT NULL,
    fecha_factura       DATE NOT NULL,
    fecha_vencimiento   DATE NOT NULL,
    quincena            DATE NOT NULL,
    id_registro         VARCHAR(6) NOT NULL,
    fecha_registro      DATE NOT NULL,
    id_ult_mod          VARCHAR(6) NOT NULL,
    fecha_ult_mod       DATE NOT NULL
)
    ON "default" go

ALTER TABLE FACTURA ADD constraint pk_factura PRIMARY KEY CLUSTERED (ID_FACTURA)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
     ON "default" 
    GO

ALTER TABLE FACTURA ADD CONSTRAINT CK_FACTURA_FCH CHECK ( FECHA_FACTURA = GETDATE() ) 
GO


ALTER TABLE factura add constraint ck_factura_ult_mod check(fecha_ult_mod = getdate() ) go

CREATE TABLE gasto 
    (
    id_proyecto      VARCHAR(8) NOT NULL,
    id_factura       VARCHAR(6) NOT NULL,
    id_proveedor     VARCHAR(6) NOT NULL,
    quincena         DATE NOT NULL,
    id_registro      VARCHAR(6) NOT NULL,
    fecha_registro   DATE NOT NULL DEFAULT GETDATE() , 
     ID_ULT_MOD VARCHAR (6) NOT NULL , 
     FECHA_ULT_MOD DATE NOT NULL DEFAULT getdate() 
    )
    ON "default" go

ALTER TABLE GASTO ADD constraint pk_gasto PRIMARY KEY CLUSTERED (ID_PROYECTO, ID_FACTURA, ID_PROVEEDOR)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
     ON "default" go

CREATE TABLE horas_trabajadas 
    (
    id_empleado         VARCHAR(6) NOT NULL,
    id_proyecto         VARCHAR(8) NOT NULL,
    cantidad_de_horas   NUMERIC(6) NOT NULL DEFAULT 1 , 
     QUINCENA DATE NOT NULL , 
     ESTADO CHAR (1) NOT NULL DEFAULT 'P' , 
     ID_REGISTRO VARCHAR (6) NOT NULL , 
     FECHA_REGISTRO DATE NOT NULL DEFAULT getdate() , 
     ID_ULT_MOD VARCHAR (6) NOT NULL , 
     FECHA_ULT_MOD DATE NOT NULL DEFAULT getdate() 
    )
    ON "default" go

ALTER TABLE horas_trabajadas add constraint ck_h_trab_estado check(
    estado = 'P'
    OR estado = 'C'
) go

CREATE TABLE l_mat_proveedor (
    codigo           VARCHAR(6) NOT NULL,
    id_factura       VARCHAR(6) NOT NULL,
    id_linea         VARCHAR(6) NOT NULL,
    id_proveedor     VARCHAR(6) NOT NULL,
    cantidad         NUMERIC(6) NOT NULL,
    costo            NUMERIC(10) NOT NULL,
    unidad_medida    CHAR(5) NOT NULL,
    costo_total      NUMERIC(10) NOT NULL,
    id_registro      VARCHAR(6) NOT NULL,
    fecha_registro   DATE NOT NULL,
    id_ult_mod       VARCHAR(6) NOT NULL,
    fecha_ult_mod    DATE NOT NULL
)
    ON "default" go

ALTER TABLE L_MAT_PROVEEDOR ADD constraint pk_l_mat_proveedor PRIMARY KEY CLUSTERED (CODIGO, ID_FACTURA, ID_LINEA, ID_PROVEEDOR)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
     ON "default" go

CREATE TABLE l_ser_proveedor (
    codigo           VARCHAR(6) NOT NULL,
    id_factura       VARCHAR(6) NOT NULL,
    id_linea         VARCHAR(6) NOT NULL,
    id_proveedor     VARCHAR(6) NOT NULL,
    costo            NUMERIC(10) NOT NULL,
    cantidad         NUMERIC(6) NOT NULL,
    unidad_medida    CHAR(4) NOT NULL,
    costo_total      NUMERIC(10) NOT NULL,
    id_registro      VARCHAR(6) NOT NULL,
    fecha_registro   DATE NOT NULL,
    id_ult_mod       VARCHAR(6) NOT NULL,
    fecha_ult_mod    DATE NOT NULL
)
    ON "default" go

ALTER TABLE L_SER_PROVEEDOR ADD constraint pk_l_ser_proveedor PRIMARY KEY CLUSTERED (ID_PROVEEDOR, ID_LINEA, ID_FACTURA, CODIGO)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
     ON "default" 
    GO
    ALTER TABLE l_ser_proveedor add constraint l_ser_proveedor unique nonclustered(id_linea)
     ON "default" go

CREATE TABLE linea_factura (
    id_factura       VARCHAR(6) NOT NULL,
    id_linea         VARCHAR(6) NOT NULL,
    id_registro      VARCHAR(6) NOT NULL,
    fecha_registro   DATE NOT NULL,
    id_ult_mod       VARCHAR(6) NOT NULL,
    fecha_ult_mod    DATE NOT NULL
)
    ON "default" go

ALTER TABLE LINEA_FACTURA ADD constraint pk_linea_factura PRIMARY KEY CLUSTERED (ID_FACTURA, ID_LINEA)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
     ON "default" 
    GO
    ALTER TABLE LINEA_FACTURA ADD CONSTRAINT LINEA_ID_FACTURA UNIQUE NONCLUSTERED (ID_FACTURA)
     ON "default" 
    GO

ALTER TABLE LINEA_FACTURA ADD CONSTRAINT CK_L_F_FCH_REGISTRO CHECK ( FECHA_REGISTRO = GETDATE() ) 
GO


ALTER TABLE linea_factura add constraint ck_l_f_fch_ult_mod check(fecha_ult_mod = getdate() ) go

CREATE TABLE mat_proveedor (
    id_proveedor     VARCHAR(6) NOT NULL,
    codigo           VARCHAR(6) NOT NULL,
    id_registro      VARCHAR(6) NOT NULL,
    fecha_registro   DATE NOT NULL,
    id_ult_mod       VARCHAR(6) NOT NULL,
    fecha_ult_mod    DATE NOT NULL
)
    ON "default" go

ALTER TABLE MAT_PROVEEDOR ADD constraint pk_mat_proveedor PRIMARY KEY CLUSTERED (CODIGO, ID_PROVEEDOR)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
     ON "default" go

CREATE TABLE material 
    (
    codigo        VARCHAR(6) NOT NULL,
    descripcion   VARCHAR(40) NOT NULL DEFAULT 'Sin descripcion' , 
     U_COSTO_COLONES NUMERIC (9) NOT NULL , 
     ID_REGISTRO VARCHAR (6) NOT NULL , 
     FECHA_REGISTRO DATE NOT NULL DEFAULT GETDATE() , 
     ID_ULT_MOD VARCHAR (6) NOT NULL , 
     FECHA_ULT_MOD DATE NOT NULL DEFAULT getdate() 
    )
    ON "default" go

ALTER TABLE MATERIAL ADD constraint material_pk PRIMARY KEY CLUSTERED (CODIGO)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
     ON "default" go

CREATE TABLE prov_servicio (
    codigo           VARCHAR(6) NOT NULL,
    id_proveedor     VARCHAR(6) NOT NULL,
    id_registro      VARCHAR(6) NOT NULL,
    fecha_registro   DATE NOT NULL,
    id_ult_mod       VARCHAR(6) NOT NULL,
    fecha_ult_mod    DATE NOT NULL
)
    ON "default" go

ALTER TABLE PROV_SERVICIO ADD constraint pk_prov_servicio PRIMARY KEY CLUSTERED (CODIGO, ID_PROVEEDOR)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
     ON "default" 
    GO

ALTER TABLE PROV_SERVICIO ADD CONSTRAINT CK_PROV_SRVC_FCH_REGISTRO CHECK ( FECHA_REGISTRO = GETDATE() ) 
GO


ALTER TABLE prov_servicio add constraint ck_prov_srvc_fch_ult_mod check(fecha_ult_mod = getdate() ) go

CREATE TABLE proveedor 
    (
    id_proveedor    VARCHAR(6) NOT NULL,
    nbr_proveedor   VARCHAR(30) NOT NULL,
    direccion       VARCHAR(50) NOT NULL DEFAULT 'Sin direccion' , 
     CEDULA NUMERIC (9) NOT NULL , 
     ID_REGISTRO VARCHAR (6) NOT NULL , 
     FECHA_REGISTRO DATE NOT NULL , 
     ID_U_MOD VARCHAR (6) NOT NULL , 
     FECHA_ULT_MOD DATE NOT NULL DEFAULT getdate() 
    )
    ON "default" go

ALTER TABLE PROVEEDOR ADD constraint pk_proveedor PRIMARY KEY CLUSTERED (ID_PROVEEDOR)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
     ON "default" 
    GO
    ALTER TABLE PROVEEDOR ADD CONSTRAINT UK_PROV_CED UNIQUE NONCLUSTERED (CEDULA)
     ON "default" 
    GO

ALTER TABLE PROVEEDOR ADD CONSTRAINT CK_PROV_FCH_REGISTRO CHECK ( FECHA_REGISTRO = getdate() ) 
GO


ALTER TABLE proveedor add constraint ck_prov_fch_u_mod check(fecha_ult_mod = getdate() ) go

CREATE TABLE proveedor_email (
    correo           VARCHAR(50) NOT NULL,
    id_proveedor     VARCHAR(6) NOT NULL,
    id_registro      VARCHAR(6) NOT NULL,
    fecha_registro   DATE NOT NULL,
    id_ult_mod       VARCHAR(6) NOT NULL,
    fecha_ult_mod    DATE NOT NULL
)
    ON "default" go

ALTER TABLE PROVEEDOR_EMAIL ADD constraint pk_email PRIMARY KEY CLUSTERED (CORREO)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
     ON "default" 
    GO

ALTER TABLE PROVEEDOR_EMAIL ADD CONSTRAINT CK_EMAIL_PROV_FCH_REGISTRO CHECK ( FECHA_REGISTRO= GETDATE() ) 
GO


ALTER TABLE proveedor_email add constraint ck_email_prov_fch_ult_mod check(fecha_ult_mod = getdate() ) go

CREATE TABLE proveedor_telefono (
    telefono         NUMERIC(8) NOT NULL,
    id_proveedor     VARCHAR(6) NOT NULL,
    id_registro      VARCHAR(6) NOT NULL,
    fecha_registro   DATE NOT NULL,
    id_ult_mod       VARCHAR(6) NOT NULL,
    fecha_ult_mod    DATE NOT NULL
)
    ON "default" go

ALTER TABLE PROVEEDOR_TELEFONO ADD constraint pk_telefono_proveedor PRIMARY KEY CLUSTERED (TELEFONO)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
     ON "default" go

CREATE TABLE proyecto 
    (
    id_proyecto   VARCHAR(8) NOT NULL,
    descripcion   VARCHAR(40) NOT NULL DEFAULT 'Sin descripcion' , 
     ID_REGISTRO VARCHAR (6) NOT NULL , 
     FECHA_REGISTRO DATE NOT NULL , 
     ID_ULT_MOD VARCHAR (6) NOT NULL , 
     FECHA_ULT_MOD DATE NOT NULL 
    )
    ON "default" go

ALTER TABLE PROYECTO ADD constraint pk_proyecto PRIMARY KEY CLUSTERED (ID_PROYECTO)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
     ON "default" go

CREATE TABLE proyecto_supervisor 
    (
    fecha_inicio   DATE NOT NULL,
    id_empleado    VARCHAR(6) NOT NULL,
    id_proyecto    VARCHAR(8) NOT NULL,
    fecha_final    DATE NOT NULL DEFAULT '2020-12-31' , 
     ID_REGISTRO VARCHAR (6) NOT NULL , 
     FECHA_REGISTRO DATE NOT NULL DEFAULT GetDate() , 
     ID_ULT_MOD VARCHAR (6) NOT NULL , 
     FECHA_ULT_MOD DATE NOT NULL DEFAULT getdate() 
    )
    ON "default" go

ALTER TABLE PROYECTO_SUPERVISOR ADD constraint proyecto_supervisor_pk PRIMARY KEY CLUSTERED (FECHA_INICIO, ID_EMPLEADO)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
     ON "default" go

CREATE TABLE servicio 
    (
    codigo        VARCHAR(6) NOT NULL,
    descripcion   VARCHAR(40) NOT NULL DEFAULT 'Sin Descripcion' , 
     ID_REGISTRO VARCHAR (6) NOT NULL , 
     FECHA_REGISTRO DATE NOT NULL DEFAULT getdate() , 
     ID_ULT_MOD VARCHAR (6) NOT NULL , 
     FECHA_ULT_MOD DATE NOT NULL DEFAULT getdate() 
    )
    ON "default" go

ALTER TABLE SERVICIO ADD constraint pk_servicio PRIMARY KEY CLUSTERED (CODIGO)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
     ON "default" 
    GO

ALTER TABLE SERVICIO ADD CONSTRAINT CK_SRVC_FCH_REGISTRO CHECK ( FECHA_REGISTRO = GETDATE() ) 
GO


ALTER TABLE servicio add constraint ck_srvc_fch_ult_mod check(fecha_ult_mod = getdate() ) go

ALTER TABLE CLIENTE_EMAIL
    ADD CONSTRAINT cliente_email_cliente_fk1 FOREIGN KEY ( id_cliente )
        REFERENCES cliente ( id_cliente )
ON DELETE NO ACTION 
    ON UPDATE no action go

ALTER TABLE CLIENTE_TELEFONO
    ADD CONSTRAINT fk_clnt_tel_client_id_cliente FOREIGN KEY ( id_cliente )
        REFERENCES cliente ( id_cliente )
ON DELETE NO ACTION 
    ON UPDATE no action go

ALTER TABLE CUENTAS_POR_COBRAR
    ADD CONSTRAINT fk_cnt_cont_id_contrato FOREIGN KEY ( id_contrato )
        REFERENCES contrato ( id_contrato )
ON DELETE NO ACTION 
    ON UPDATE no action go

ALTER TABLE CONTRATO
    ADD CONSTRAINT fk_cont_clnt_id_cliente FOREIGN KEY ( id_cliente )
        REFERENCES cliente ( id_cliente )
ON DELETE NO ACTION 
    ON UPDATE no action go

ALTER TABLE CONTRATO
    ADD CONSTRAINT fk_cont_pry_id_proyecto FOREIGN KEY ( id_proyecto )
        REFERENCES proyecto ( id_proyecto )
ON DELETE NO ACTION 
    ON UPDATE no action go

ALTER TABLE PROVEEDOR_EMAIL
    ADD CONSTRAINT fk_email_prov_id_proveedor FOREIGN KEY ( id_proveedor )
        REFERENCES proveedor ( id_proveedor )
ON DELETE NO ACTION 
    ON UPDATE no action go

ALTER TABLE EMPLEADO_PROYECTO
    ADD CONSTRAINT fk_emp_pry_id_empleado FOREIGN KEY ( id_empleado )
        REFERENCES empleado ( id_empleado )
ON DELETE NO ACTION 
    ON UPDATE no action go

ALTER TABLE EMPLEADO_PROYECTO
    ADD CONSTRAINT fk_emp_pry_id_proyecto FOREIGN KEY ( id_proyecto )
        REFERENCES proyecto ( id_proyecto )
ON DELETE NO ACTION 
    ON UPDATE no action go

ALTER TABLE FACTURA
    ADD CONSTRAINT fk_fact_prov_id_proveedor FOREIGN KEY ( id_proveedor )
        REFERENCES proveedor ( id_proveedor )
ON DELETE NO ACTION 
    ON UPDATE no action go

ALTER TABLE FACTURA
    ADD CONSTRAINT fk_fact_pry_id_proyecto FOREIGN KEY ( id_proyecto )
        REFERENCES proyecto ( id_proyecto )
ON DELETE NO ACTION 
    ON UPDATE no action go

ALTER TABLE GASTO
    ADD CONSTRAINT fk_gst_fact_id_factura FOREIGN KEY ( id_factura )
        REFERENCES factura ( id_factura )
ON DELETE NO ACTION 
    ON UPDATE no action go

ALTER TABLE GASTO
    ADD CONSTRAINT fk_gst_prov_id_proveedor FOREIGN KEY ( id_proveedor )
        REFERENCES proveedor ( id_proveedor )
ON DELETE NO ACTION 
    ON UPDATE no action go

ALTER TABLE GASTO
    ADD CONSTRAINT fk_gst_pry_id_proyecto FOREIGN KEY ( id_proyecto )
        REFERENCES proyecto ( id_proyecto )
ON DELETE NO ACTION 
    ON UPDATE no action go

ALTER TABLE HORAS_TRABAJADAS
    ADD CONSTRAINT fk_h_trab_emp_id_empleado FOREIGN KEY ( id_empleado )
        REFERENCES empleado ( id_empleado )
ON DELETE NO ACTION 
    ON UPDATE no action go

ALTER TABLE L_MAT_PROVEEDOR
    ADD CONSTRAINT fk_l_mat_prov_fact_id_factura FOREIGN KEY ( id_factura )
        REFERENCES linea_factura ( id_factura )
ON DELETE NO ACTION 
    ON UPDATE no action go

ALTER TABLE L_SER_PROVEEDOR
    ADD CONSTRAINT fk_l_ser_prov_fact_id_factura FOREIGN KEY ( id_factura )
        REFERENCES linea_factura ( id_factura )
ON DELETE NO ACTION 
    ON UPDATE no action go

ALTER TABLE L_SER_PROVEEDOR
    ADD CONSTRAINT fk_l_ser_prov_ser_codigo FOREIGN KEY ( codigo )
        REFERENCES servicio ( codigo )
ON DELETE NO ACTION 
    ON UPDATE no action go

ALTER TABLE MAT_PROVEEDOR
    ADD CONSTRAINT fk_mat_prov_mat_codigo FOREIGN KEY ( codigo )
        REFERENCES material ( codigo )
ON DELETE NO ACTION 
    ON UPDATE no action go

ALTER TABLE MAT_PROVEEDOR
    ADD CONSTRAINT fk_mat_prov_prov_id_proveedor FOREIGN KEY ( id_proveedor )
        REFERENCES proveedor ( id_proveedor )
ON DELETE NO ACTION 
    ON UPDATE no action go

ALTER TABLE PROV_SERVICIO
    ADD CONSTRAINT fk_prov_srvc_codigo FOREIGN KEY ( codigo )
        REFERENCES servicio ( codigo )
ON DELETE NO ACTION 
    ON UPDATE no action go

ALTER TABLE PROV_SERVICIO
    ADD CONSTRAINT fk_prov_srvc_id_proveedor FOREIGN KEY ( id_proveedor )
        REFERENCES proveedor ( id_proveedor )
ON DELETE NO ACTION 
    ON UPDATE no action go

ALTER TABLE PROVEEDOR_TELEFONO
    ADD CONSTRAINT fk_tel_prov_id_proveedor FOREIGN KEY ( id_proveedor )
        REFERENCES proveedor ( id_proveedor )
ON DELETE NO ACTION 
    ON UPDATE no action go

ALTER TABLE L_MAT_PROVEEDOR
    ADD CONSTRAINT l_mat_proveedor_fk1 FOREIGN KEY ( codigo )
        REFERENCES material ( codigo )
ON DELETE NO ACTION 
    ON UPDATE no action go

ALTER TABLE LINEA_FACTURA
    ADD CONSTRAINT linea_factura_factura_fk FOREIGN KEY ( id_factura )
        REFERENCES factura ( id_factura )
ON DELETE NO ACTION 
    ON UPDATE no action go

ALTER TABLE PROYECTO_SUPERVISOR
    ADD CONSTRAINT proyecto_supervisor_fk1 FOREIGN KEY ( id_empleado )
        REFERENCES empleado ( id_empleado )
ON DELETE NO ACTION 
    ON UPDATE no action go

ALTER TABLE PROYECTO_SUPERVISOR
    ADD CONSTRAINT proyecto_supervisor_fk2 FOREIGN KEY ( id_proyecto )
        REFERENCES proyecto ( id_proyecto )
ON DELETE NO ACTION 
    ON UPDATE no action go



-- Oracle SQL Developer Data Modeler Summary Report: 
-- 
-- CREATE TABLE                            22
-- CREATE INDEX                             0
-- ALTER TABLE                             68
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- CREATE DATABASE                          0
-- CREATE DEFAULT                           0
-- CREATE INDEX ON VIEW                     0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE ROLE                              0
-- CREATE RULE                              0
-- CREATE SCHEMA                            0
-- CREATE SEQUENCE                          0
-- CREATE PARTITION FUNCTION                0
-- CREATE PARTITION SCHEME                  0
-- 
-- DROP DATABASE                            0
-- 
-- ERRORS                                   1
-- WARNINGS                                 0
