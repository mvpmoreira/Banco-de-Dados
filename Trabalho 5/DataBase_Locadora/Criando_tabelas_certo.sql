CREATE DATABASE Locadora_Veiculos
DEFAULT CHARACTER SET utf8
DEFAULT COLLATE utf8_general_ci;

CREATE TABLE pessoa_fisica (
	CPF CHAR(14),
	Nasc DATE NOT NULL,
	Nome VARCHAR(255) NOT NULL,

	PRIMARY KEY (CPF)
) DEFAULT CHARSET = utf8;

CREATE TABLE pessoa_juridica (
	CNPJ CHAR(18),
	Nome_fantasia VARCHAR(255) UNIQUE,

	PRIMARY KEY (CNPJ)
)DEFAULT CHARSET = utf8;

CREATE TABLE locatario (
	Conta VARCHAR(20),
	CPF CHAR(14) NULL,
	CNPJ CHAR(18) NULL,
	Agencia VARCHAR(20) NOT NULL,

	PRIMARY KEY(Conta),
	FOREIGN KEY (CPF) REFERENCES pessoa_fisica(CPF),
	FOREIGN KEY (CNPJ) REFERENCES pessoa_juridica(CNPJ)
)DEFAULT CHARSET = utf8;

CREATE TABLE funcionario (
	Reg_func VARCHAR(10),
	CNPJ CHAR(18),
	CPF CHAR(14),

	PRIMARY KEY (Reg_func),
	FOREIGN KEY (CPF) REFERENCES pessoa_fisica(CPF),
	FOREIGN KEY (CNPJ) REFERENCES pessoa_juridica(CNPJ)
)DEFAULT CHARSET = utf8;

CREATE TABLE veiculo (
	Placa CHAR(7),
	Chassi CHAR(17) UNIQUE,
	Dimensoes VARCHAR(50),
	Categoria ENUM('Utilitário', 'Passeio', 'Comercial', 'Esportivo', 'SUV', 'Outro'),
	Marca VARCHAR(50),
	Cor VARCHAR(15),
	Modelo VARCHAR(50) NOT NULL,
	Bebe_confort BOOLEAN,
	Ar_cond BOOLEAN NOT NULL,
	Mecaniz ENUM('Automático', 'Manual') NOT NULL,
    Preco DECIMAL(6, 2),

	PRIMARY KEY (Placa)
)DEFAULT CHARSET = utf8;

CREATE TABLE condutor (
		CNH CHAR(11),
		CPF CHAR(14),
		Placa CHAR(7),
		Conta VARCHAR(20),
		Venc_CNH DATE,
		Cond_princ BOOLEAN NOT NULL, 

		PRIMARY KEY (CNH, CPF),
		FOREIGN KEY (CPF) REFERENCES pessoa_fisica(CPF),
		FOREIGN KEY (Placa) REFERENCES veiculo(Placa),
		FOREIGN KEY (Conta) REFERENCES locatario(Conta)
)DEFAULT CHARSET = utf8;

CREATE TABLE prontuario (
	Placa CHAR(7),
	Quilometragem MEDIUMINT UNSIGNED NOT NULL,
	Revisao BOOLEAN NOT NULL,
	Idade_vei TINYINT UNSIGNED,
	Est_conserv ENUM('Novo', 'Bom', 'Regular', 'Ruim') NOT NULL,
	Press_pneu DECIMAL(3,1),
	Niv_oleo DECIMAL(5,2),

	PRIMARY KEY (Placa),
	FOREIGN KEY (Placa) REFERENCES veiculo(Placa)
)DEFAULT CHARSET = utf8;

CREATE TABLE fila_espera (
	Num_consul INT AUTO_INCREMENT,
	Data_consul DATETIME,

	PRIMARY KEY (Num_consul)
)DEFAULT CHARSET = utf8;

CREATE TABLE subsis_reserv (
	Placa CHAR(7),
	Num_consul INT,
	Num_client VARCHAR(15),

	PRIMARY KEY (Num_consul, Placa),
	FOREIGN KEY (Placa) REFERENCES veiculo(Placa),
	FOREIGN KEY (Num_consul) REFERENCES fila_espera(Num_consul)
)DEFAULT CHARSET = utf8;

CREATE TABLE foto_ilus (
	Placa CHAR(7),
	Id_foto INT AUTO_INCREMENT,
	Foto BLOB NOT NULL,

	PRIMARY KEY (Id_foto, Placa),
	FOREIGN KEY (Placa) REFERENCES veiculo(Placa)
)DEFAULT CHARSET = utf8;

CREATE TABLE subsis_locacao (
	Num_reserv INT AUTO_INCREMENT,
	Placa CHAR(7),
	Conta VARCHAR(20),
	CPF CHAR(14),
	Seguros_ad BOOLEAN NOT NULL,
	Data_retirada_prev DATETIME,
	Data_retirada_efet DATETIME NOT NULL,
	Data_compra DATE NOT NULL,
	Data_devol_prev DATETIME,
	Data_devol_efet DATETIME NOT NULL,
	Patio_entra VARCHAR(255) ,
	Patio_saida VARCHAR(255),
    

	PRIMARY KEY (Num_reserv),
	FOREIGN KEY (CPF) REFERENCES pessoa_fisica(CPF),
	FOREIGN KEY (Placa) REFERENCES veiculo(Placa),
	FOREIGN KEY (Conta) REFERENCES locatario(Conta)
)DEFAULT CHARSET = utf8;