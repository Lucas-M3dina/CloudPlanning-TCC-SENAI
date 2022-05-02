CREATE DATABASE CloudPlanning;
GO

USE CloudPlanning;
GO

CREATE TABLE TipoUsuario(
	idTipoUsuario INT PRIMARY KEY IDENTITY,
	permissao VARCHAR(50)
)

CREATE TABLE Usuario(
	idUsuario INT PRIMARY KEY IDENTITY,
	idTipoUsuario INT FOREIGN KEY REFERENCES TipoUsuario(idTipoUsuario),
	email VARCHAR(50) NOT NULL UNIQUE,
	senha VARCHAR(70) NOT NULL
)
GO

CREATE TABLE Empresa(
	idEmpresa INT PRIMARY KEY IDENTITY,
	idUsuario INT FOREIGN KEY REFERENCES usuario(idUsuario),
	CNPJ VARCHAR(14) NOT NULL UNIQUE,
	nomeFantasia VARCHAR(70) NOT NULL UNIQUE,
	telefone VARCHAR(14) NOT NULL UNIQUE
);
GO

CREATE TABLE UsuarioComum(
	idUsuarioComum INT PRIMARY KEY IDENTITY,
	idUsuario INT FOREIGN KEY REFERENCES usuario(idUsuario),
	idEmpresa INT FOREIGN KEY REFERENCES empresa(IdEmpresa),
	nome VARCHAR (70),
	CPF VARCHAR (12) NOT NULL UNIQUE,
	DataNascimento DATE NOT NULL,
)
GO

CREATE TABLE VPC(
	idVPC INT PRIMARY KEY IDENTITY,
	idRoute INT FOREIGN KEY REFERENCES Rota(idRoute),
	idSubnet INT FOREIGN KEY REFERENCES Subnet(idSubnet),
	idGrupoSeguranca INT FOREIGN KEY REFERENCES Grupo_Seguranca(idGrupoSeguranca),
	nome VARCHAR(50), 
	imagemComponente VARCHAR(70), 
	descricao VARCHAR(100),
	natGateway varchar(20) NOT NULL,
)
GO


CREATE TABLE EC2(
	idEC2 INT PRIMARY KEY IDENTITY,
	idVPC INT FOREIGN KEY REFERENCES VPC(idVPC),
	nome VARCHAR(50), 
	imagemComponente VARCHAR(70), 
	descricao VARCHAR(100),
	sistemaOperacional VARCHAR(20) NOT NULL,
	armazenamento INT NOT NULL,
	quantidadeProcessadores INT NOT NULL,
	RAM INT NOT NULL,
	subRede VARCHAR(20) NOT NULL,
	autoAssign BIT DEFAULT(0),
	nomeChave VARCHAR(50)
)
GO

CREATE TABLE Subnet(
	idSubnet INT PRIMARY KEY IDENTITY,
	nome VARCHAR(50), 
	ipSubnet VARCHAR(15), 
	area VARCHAR(3),
	subRede VARCHAR(20) NOT NULL,
	mascara VARCHAR(20) NOT NULL,
	acesso varchar(20) NOT NULL,
)
GO

CREATE TABLE Rota(
	idRoute INT PRIMARY KEY IDENTITY,
	nomeRoute VARCHAR(50), 
	blockIp VARCHAR(15), 
	ipOrigem VARCHAR(20),
	ipDestino VARCHAR(20) NOT NULL,
)
GO

CREATE TABLE Grupo_Seguranca(
	idGrupoSeguranca INT PRIMARY KEY IDENTITY,
	NomeGrupoSeguranca VARCHAR(40),
	from_port_ingress VARCHAR(40),
	to_port_ingress VARCHAR(40),
	protocol_ingress VARCHAR(40),
	cidr_blocks_ingress VARCHAR(40),
	from_port_egress VARCHAR(40),
	to_port_egress VARCHAR(40),
	protocol_egress VARCHAR(40),
	cidr_blocks_egress VARCHAR(40),
)

CREATE TABLE Diagrama(
	idDiagrama INT PRIMARY KEY IDENTITY,
	idEmpresa INT FOREIGN KEY REFERENCES empresa(idEmpresa),
	idEC2 INT FOREIGN KEY REFERENCES EC2(idEC2),
	nome VARCHAR(70) NOT NULL UNIQUE,
);
GO


