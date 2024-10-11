---
"Documentación de la práctica 1: Modelo E/R Farmacia"
---

# Índice
- [Índice](#índice)
- [Enunciado](#enunciado)
- [Entrega](#entrega)
  - [1. Descripción de cada una de las entidades.](#1-descripción-de-cada-una-de-las-entidades)
    - [**Medicamento**](#medicamento)
    - [**Farmacia**](#farmacia)
    - [**Familia**](#familia)
    - [**Laboratorio**](#laboratorio)
    - [**Socio**](#socio)
  - [2. Descripción y ejemplos ilustrativos del dominio de cada uno de los atributos de las entidades y de las relaciones.](#2-descripción-y-ejemplos-ilustrativos-del-dominio-de-cada-uno-de-los-atributos-de-las-entidades-y-de-las-relaciones)
    - [**Medicamento**](#medicamento-1)
    - [**Farmacia**](#farmacia-1)
    - [**Familia**](#familia-1)
    - [**Laboratorio**](#laboratorio-1)
    - [**Socio**](#socio-1)
  - [3. Descripción de cada una de las relaciones definidas.](#3-descripción-de-cada-una-de-las-relaciones-definidas)
    - [**Medicamento-familia**](#medicamento-familia)
    - [Relación: Pertenece/Contiene](#relación-pertenececontiene)
    - [**Medicamento-laboratorio**](#medicamento-laboratorio)
    - [Relación: Fabricado](#relación-fabricado)
    - [**Medicamento-farmacia**](#medicamento-farmacia)
    - [Relación: Fabricado](#relación-fabricado-1)
    - [Relación: Vender](#relación-vender)
    - [**Farmacia-socio**](#farmacia-socio)
    - [Relación: Comprar/Vender](#relación-comprarvender)
    - [**Farmacia-laboratorio**](#farmacia-laboratorio)
    - [Relación: Comprar/Vender](#relación-comprarvender-1)
  - [4. Restricciones semánticas](#4-restricciones-semánticas)
    - [Restricciones semánticas en el modelo entidad-relación](#restricciones-semánticas-en-el-modelo-entidad-relación)
      - [1. Relaciones](#1-relaciones)
      - [2. Entidades y atributos identificadores](#2-entidades-y-atributos-identificadores)
      - [3. Condiciones sobre los atributos](#3-condiciones-sobre-los-atributos)


# Enunciado 
La gestión de una farmacia requiere poder llevar control de los medicamentos existentes, 
así como de los que se van sirviendo, para lo cual se pretende diseñar un sistema acorde
 a las siguientes especificaciones:

- En la farmacia se requiere una catalogación de todos los medicamentos existentes, para
lo cual se almacenará un código de medicamento, nombre del medicamento, tipo de medicamento
(jarabe, comprimido, pomada,...) unidades en stock, unidades vendidas y precio. Existen 
medicamentos de venta libre y otros que sólo se pueden dispensar con receta médica.

- La farmacia compra cada medicamento a un laboratorio, o bien los fabrica ella misma.
Se desea conocer el código del laboratorio, nombre, teléfono, dirección postal y fax, 
así como el nombre de la persona de contacto.

- Los medicamentos se agrupan en familias, dependiendo del tipo de enfermedades a las 
que dicho medicamento se aplica. De este modo, si la farmacia no dispone de un medicamento 
concreto, puede vender otro similar aunque de distinto laboratorio.

- La farmacia tiene algunos clientes que realizan los pagos de sus pedidos a fin de cada
mes (clientes con crédito). La farmacia quiere mantener las unidades de cada medicamento
comprado por los clientes (con o sin crédito) así como la fecha de compra. Además, es
necesario conocer los datos bancarios de los clientes con crédito, así como la fecha
de pago de las compras que realizan.

# Entrega

## 1. Descripción de cada una de las entidades.
### **Medicamento**
El medicamento es la entidad principal de la farmacia, ya que es el producto que se vende.
Cada medicamento tiene un código, un nombre, un tipo, unidades en stock, unidades vendidas
y precio. Además, se puede dispensar con receta médica o no.

### **Farmacia**
La farmacia es la entidad que vende/fabrica los medicamentos. La farmacia registra las
transacciones de compra y venta de medicamentos.

### **Familia**
La familia agrupa los medicamentos según el tipo de enfermedad que tratan. De esta forma,
si la farmacia no dispone de un medicamento concreto, puede vender otro similar aunque
de distinto laboratorio.

### **Laboratorio**
El laboratorio suministra los medicamentos a la farmacia. Cada laboratorio tiene un código,
un nombre, un teléfono, una dirección postal, un fax y el nombre de la persona de contacto.

### **Socio**
El cliente es la entidad que compra los medicamentos. Algunos clientes realizan los pagos
de sus pedidos a fin de cada mes (clientes con crédito). La farmacia quiere mantener las
unidades de cada medicamento comprado por los clientes (con o sin crédito) así como la
fecha de compra. Además, es necesario conocer los datos bancarios de los clientes con
crédito, así como la fecha de pago de las compras que realizan.

## 2. Descripción y ejemplos ilustrativos del dominio de cada uno de los atributos de las entidades y de las relaciones.
### **Medicamento**
<p align="center">
  <img src="images/FULLmedicamento.png" alt="Diagrama de Medicamento">
</p>

- `(PK)` UID: `número`

  - Puede tomar cualquier valor de tipo `número` que represente el UID del medicamento. Ejemplo: "123456"

- Nombre Medicamento: `palabra`

  - Puede tomar cualquier valor de tipo `palabra` que represente el nombre del medicamento. Ejemplo: "Ibuprofeno"

- Tipo Medicamento: `palabra`

  - Puede tomar cualquier valor de tipo `palabra` que represente el tipo de medicamento. Ejemplo: "Comprimido"
  
- Unidades en stock: `número`
  
  - Puede tomar cualquier valor de tipo `número` que represente las unidades en stock del medicamento. Ejemplo: "100" 

- Unidades vendidas: `número`
    
  - Puede tomar cualquier valor de tipo `número` que represente las unidades vendidas del medicamento. Ejemplo: "50"

- Precio: `número`

  - Puede tomar cualquier valor de tipo `número` que represente el precio del medicamento. Ejemplo: "5.50"

- Tipo de venta: `palabra`

  - Puede tomar cualquier valor de tipo `palabra` que represente el tipo de venta del medicamento. Ejemplo: "Con receta"


### **Farmacia**
<p align="center">
  <img src="images/FULLfarmacia.png" alt="Diagrama de Laboratorio">
</p>

- `(PK)` ID de transferencia: `número`

  - Puede tomar cualquier valor de tipo `número` que represente el ID de transferencia de la farmacia. Ejemplo: "123456"

- Fecha de compra: `fecha`

  - Puede tomar cualquier valor de tipo `fecha` que represente la fecha de compra de la farmacia. Ejemplo: "2021-10-01"

- Fecha de pago: `fecha`
  - Puede tomar cualquier valor de tipo `fecha` que represente la fecha de pago de la farmacia. Ejemplo: "2021-10-31"

- Unidades compradas: `número`

  - Puede tomar cualquier valor de tipo `número` que represente las unidades compradas de la farmacia. Ejemplo: "100"

- Credito: `boolean`

  - Puede tomar cualquier valor de tipo `boolean` que represente si el cliente tiene crédito o no. Ejemplo: "True"

- Pagado: `boolean`

  - Puede tomar cualquier valor de tipo `boolean` que represente si el cliente ha pagado o no. Este valor se calcula mediante la fecha de pago. Ejemplo: "True" 


### **Familia**
<p align="center">
  <img src="images/FULLfamilia.png" alt="Diagrama de Laboratorio">
</p>

- `(PK)` Tipo de enfermedad: `string`

  - Puede tomar cualquier valor de tipo `string` que represente el tipo de enfermedad que trata el medicamento. Ejemplo: "Dolor de cabeza" 
- Nombre de medicamento: `string`

  - Puede tomar cualquier valor de tipo `string` que represente el nombre del medicamento. Ejemplo: "Ibuprofeno" 

### **Laboratorio**
<p align="center">
  <img src="images/FULLlaboratorio.png" alt="Diagrama de Laboratorio">
</p>

- `(PK)` Código de laboratorio: `palabra`

  - Puede tomar cualquier valor de tipo `palabra` que represente el código del laboratorio. Ejemplo: "LAB001"

- Nombre de laboratorio: `palabra`

  - Puede tomar cualquier valor de tipo `palabra` que represente el nombre del laboratorio. Ejemplo: "Pfizer"

- Teléfono: `número`

  - Puede tomar cualquier valor de tipo `número` que represente el teléfono del laboratorio. Ejemplo: "123456789"

- Dirección postal: `palabra`

  - Puede tomar cualquier valor de tipo `palabra` que represente la dirección postal del laboratorio. Ejemplo: "Calle Falsa 123"

- Fax: `número`

  - Puede tomar cualquier valor de tipo `número` que represente el fax del laboratorio. Ejemplo: "987654321"

- Nombre de persona de contacto: `palabra`

  - Puede tomar cualquier valor de tipo `palabra` que represente el nombre de la persona de contacto del laboratorio. Ejemplo: "Juan Pérez"


### **Socio**
<p align="center">
  <img src="images/FULLsocio.png" alt="Diagrama de Laboratorio">
</p>

- `(PK)` DNI: `número`

  - Puede tomar cualquier valor de tipo `número` que represente el DNI del socio. Ejemplo: "12345678Z"

- Nombre: `palabra`

  - Puede tomar cualquier valor de tipo `palabra` que represente el nombre del socio. Ejemplo: "Juan"

- Apellidos: `palabra`

  - Puede tomar cualquier valor de tipo `palabra` que represente los apellidos del socio. Ejemplo: "Pérez"

- Dirección: `palabra`

  - Puede tomar cualquier valor de tipo `palabra` que represente la dirección del socio. Ejemplo: "Calle Falsa 123"

- Datos bancarios: `palabra`

  - Puede tomar cualquier valor de tipo `palabra` que represente los datos bancarios del socio. Ejemplo: "ES123456789"


## 3. Descripción de cada una de las relaciones definidas.
### **Medicamento-familia**
<p align="center">
  <img src="images/medicamento-familia.png" alt="Diagrama de medicamento-familia">

  ### Relación: Pertenece/Contiene
  Muestra la relación entre un medicamento y una familia de medicamentos. 

  La cardinalidad de la relación es:

  - **(1, N)** para la familia de medicamentos, una familia pertenece a mínimo un medicamento y máximo N medicamentos, ya que pueden existir muchos medicamentos que curen a una misma familia de enfermedad.
  - **(1, M)** para los medicamentos, un medicamento pertenece a mínimo una familia y máximo a N familias, debido a que un mismo medicamento puede curar distintos tipos de enfermedades.
</p>

### **Medicamento-laboratorio**
<p align="center">
  <img src="images/medicamento-laboratorio.png" alt="Diagrama de medicamento-laboratorio">

  ### Relación: Fabricado
  Muestra la relación entre un medicamento y un laboratorio de medicamentos.

  La cardinalidad de la relación es:

  - **(1, N)** para el laboratorio, un laboratorio fabrica mínimo un medicamento y máximo N medicamentos.
  - **(1, 1)** para los medicamentos, ya que un mismo medicamento sólo puede ser fabricado en un único laboratorio.
</p>

### **Medicamento-farmacia**
<p align="center">
  <img src="images/medicamento-farmacia.png" alt="Diagrama de medicamento-farmacia">

  Estas dos entidades presentan dos relaciones distintas ya que pueden relacionarse bien en la fabricación de los medicamentos o bien en la venta de estos.

  ### Relación: Fabricado
  Muestra la relación entre un medicamento y una farmacia de medicamentos. 

  La cardinalidad de la relación es:

  - **(1, N)** para la farmacia de medicamentos, una farmacia puede fabricar 1 o varios medicamentos.
  - **(0, 1)** para los medicamentos, un medicamento puede ser fabricado o no por dicha farmacia.

  ### Relación: Vender
  Muestra la relación entre un medicamento y una farmacia de medicamentos. 

  La cardinalidad de la relación es:

  - **(1, N)** para la farmacia de medicamentos, ya que una farmacia vende mínimo un medicamento y máximo N medicamentos.
  - **(1, 1)** para los medicamentos, un medicamento puede ser vendido por una sóla farmacia.
</p>

### **Farmacia-socio**
<p align="center">
  <img src="images/farmacia-socio.png" alt="Diagrama de farmacia-socio">

  ### Relación: Comprar/Vender
  Muestra la relación entre una farmacia y un socio.

  La cardinalidad de la relación es:

  - **(1, 1)** para el socio, un socio de una farmacia sólo puede comprar en dicha farmacia.
  - **(0, N)** para la farmacia, ya que una farmacia puede o no vender a socios, los que definimos como clientes con crédito.

</p>

### **Farmacia-laboratorio**
<p align="center">
  <img src="images/farmacia-laboratorio.png" alt="Diagrama de farmacia-laboratorio">

  ### Relación: Comprar/Vender
  Muestra la relación entre una farmacia y un laboratorio de medicamentos.

  La cardinalidad de la relación es:

  - **(1, M)** para el laboratorio de medicamentos, ya que un laboratorio puede vender a una o muchas farmacias.
  - **(1, N)** para la farmacia, ya que una farmacia puede comprar a 1 o más laboratorios.
  
</p>

## 4. Restricciones semánticas

### Restricciones semánticas en el modelo entidad-relación

#### 1. Relaciones
- **Dependencia de existencia**: Varias relaciones en el modelo implican que una entidad no puede existir sin estar vinculada a otra entidad. Por ejemplo, la relación "pertenece/contiene" entre *Medicamento* y *Familia* sugiere que un medicamento debe estar asociado con una familia y viceversa ya que no puede existir un medicamento que no pertenezca a ninguna familia y tampoco puede existir una familia de medicamentos sin que tenga algún medicamento asociado.
  
- **Integridad referencial**: Para las relaciones como "Vender" y "Comprar/Vender", se asegura que las farmacias y socios solo interactúan con medicamentos o productos existentes, lo que implica una validación de la integridad de las relaciones al momento de realizar operaciones.

- **Unicidad en las asociaciones**: Algunas relaciones, como "Fabricado", imponen restricciones de exclusividad, donde un medicamento sólo puede estar asociado a un único laboratorio, lo que garantiza la integridad en el origen de los medicamentos.

#### 2. Entidades y atributos identificadores
- **Atributos identificadores únicos**: Todas las entidades cuentan con identificadores únicos (como *UID*, *DNI*, o *C. Lab*) que aseguran la unicidad y la integridad dentro del sistema. Estos atributos son cruciales para evitar duplicidades y garantizar la correcta identificación de cada instancia en las bases de datos.

- **Restricciones de integridad de los datos**: Atributos como el precio del medicamento, las fechas de pago y compra, y los datos bancarios de los socios están sujetos a restricciones de integridad, lo que asegura que se introduzcan datos válidos y consistentes dentro del modelo.

#### 3. Condiciones sobre los atributos
- **Validaciones temporales**: Atributos como la *Fecha de Compra* y *Fecha de Pago* en las transacciones de venta sugieren la existencia de restricciones que aseguran que las fechas tengan coherencia lógica (por ejemplo, la fecha de pago debe ser posterior a la fecha de compra).

- **Integridad sobre valores**: Otros atributos como las unidades vendidas o el crédito en farmacias pueden estar sujetos a restricciones adicionales de negocio, como límites en el crédito o cantidades mínimas o máximas que se pueden vender, las cuales deben ser respetadas para mantener la coherencia de las operaciones.

Este conjunto de restricciones semánticas mejora la interpretación del modelo y asegura que los datos ingresados cumplan con las reglas del negocio y las relaciones reales entre las entidades.

