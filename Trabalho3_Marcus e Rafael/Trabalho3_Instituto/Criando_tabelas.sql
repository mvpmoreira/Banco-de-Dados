CREATE TABLE Pagina_web (
    Link_web VARCHAR(255),
    Num_visit MEDIUMINT UNSIGNED,
    Temp_perman TIME,
    Tipo BOOL,
    PRIMARY KEY (Link_web)
);



CREATE TABLE Local_atv (
    Id_loc INT AUTO_INCREMENT,
    Link_web VARCHAR(255),
    Horario_fun TEXT,
    Itens_proces TEXT,
    Tipo_loc TEXT,
    Cont_tel_atv TEXT,
    Capacidade SMALLINT UNSIGNED,
    PRIMARY KEY (Id_loc),
    FOREIGN KEY (Link_web) REFERENCES Pagina_web(Link_web)
);



CREATE TABLE Endereco_Local_atv (
    Id_loc INT AUTO_INCREMENT,
    Rua VARCHAR(255) NOT NULL,
    Numero SMALLINT UNSIGNED NOT NULL,
    Complemento VARCHAR(255) NOT NULL,
    Bairro VARCHAR(255) NOT NULL,
    Cidade VARCHAR(255) NOT NULL,
    Estado ENUM('AC', 'AL', 'AP', 'AM', 'BA', 'CE', 'DF', 'ES', 'GO', 'MA', 'MT', 'MS', 'MG', 'PA', 'PB', 'PR', 'PE', 'PI', 'RJ', 'RN', 'RS', 'RO', 'RR', 'SC', 'SP', 'SE', 'TO') NOT NULL,
    PRIMARY KEY (Id_loc),
    FOREIGN KEY (Id_loc) REFERENCES Local_atv(Id_loc)
);



CREATE TABLE Tema (
    Nome_tema VARCHAR(255),
    Link_web VARCHAR(255),
    PRIMARY KEY (Nome_tema),
    FOREIGN KEY (Link_web) REFERENCES Pagina_web(Link_web)
);



CREATE TABLE Comite (
    Sala_virtual VARCHAR(255),
    Nome_tema VARCHAR(255),
    PRIMARY KEY (Sala_virtual),
    FOREIGN KEY (Nome_tema) REFERENCES Tema(Nome_tema)
);



CREATE TABLE Projeto (
    Id_proj INT AUTO_INCREMENT,
    Nome_tema VARCHAR(255),
    Titulo VARCHAR(255) NOT NULL,
    Situacao ENUM('Em proposta', 'Iniciado', 'Em andamento', 'Suspenso', 'Finalizado') NOT NULL,
    Orcamento DECIMAL(12,2) NOT NULL,
    PRIMARY KEY (Id_proj),
    FOREIGN KEY (Nome_tema) REFERENCES Tema(Nome_tema)
);
    
    

CREATE TABLE Documento (
    Id_doc INT AUTO_INCREMENT,
    Id_proj INT,
    PRIMARY KEY (Id_doc),
    FOREIGN KEY (Id_proj) REFERENCES Projeto(Id_proj)
);    
    


CREATE TABLE Doc_descrit (
    Id_doc INT,
    Id_proj INT,
    Detal_atv TEXT NOT NULL,
    Detal_etapa TEXT NOT NULL,
    Cronograma TEXT NOT NULL,
    Lista_envolv TEXT NOT NULL,
    Plan_control_fin BLOB,
    Data_inicio DATE NOT NULL,
    Data_fim_prev DATE NOT NULL,
    Data_fim_efet DATE NOT NULL,
    PRIMARY KEY (Id_doc),
    FOREIGN KEY (Id_doc) REFERENCES Documento(Id_doc),
    FOREIGN KEY (Id_proj) REFERENCES Documento(Id_proj)
);    
    


CREATE TABLE Doc_proposta (
    Id_doc INT,
    Id_proj INT,
    Merito TEXT NOT NULL,
    PRIMARY KEY (Id_doc),
    FOREIGN KEY (Id_doc) REFERENCES Documento(Id_doc),
    FOREIGN KEY (Id_proj) REFERENCES Documento(Id_proj)
);    
    
    

CREATE TABLE Doc_result (
    Id_doc INT,
    Id_proj INT,
    Result_assoc TEXT NOT NULL,
    PRIMARY KEY (Id_doc),
    FOREIGN KEY (Id_doc) REFERENCES Documento(Id_doc),
    FOREIGN KEY (Id_proj) REFERENCES Documento(Id_proj)
);
    
    

CREATE TABLE KPIs_Doc_result (
    Id_doc INT,
    Descricao VARCHAR(255) NOT NULL,
    Obj_num MEDIUMINT UNSIGNED NOT NULL,
    PRIMARY KEY (Id_doc),
    FOREIGN KEY (Id_doc) REFERENCES Documento(Id_doc)
);
    
    

CREATE TABLE OKRs_Doc_result (
    Id_doc INT,
    OKR TEXT NOT NULL,
    PRIMARY KEY (Id_doc),
    FOREIGN KEY (Id_doc) REFERENCES Documento(Id_doc)
);
    
    

CREATE TABLE Result_assoc_Doc_result (
    Id_doc INT,
    Result_assoc TEXT NOT NULL,
    PRIMARY KEY (Id_doc),
    FOREIGN KEY (Id_doc) REFERENCES Documento(Id_doc) 
);

    

CREATE TABLE Colaborador (
    CPF CHAR(14),
    Nome VARCHAR(255) NOT NULL,
    Profissao VARCHAR(255),
    RG CHAR(11) NOT NULL UNIQUE,
    Data_nasc DATE NOT NULL,
    Contato VARCHAR(9),
    Empresa VARCHAR(255),
    Pis_pasep CHAR(18),
    PRIMARY KEY (CPF)
);
    
    

CREATE TABLE Membro_int (
    CPF CHAR(14),
    Cart_inst CHAR(12) NOT NULL UNIQUE,
    Nome_tema VARCHAR(255),
    PRIMARY KEY (CPF),
    FOREIGN KEY (CPF) REFERENCES Colaborador(CPF),
    FOREIGN KEY (Nome_tema) REFERENCES Tema(Nome_tema)
);
    
    

CREATE TABLE Membro_comit (
    CPF CHAR(14),
    Sala_virtual VARCHAR(255),
    PRIMARY KEY (CPF),
    FOREIGN KEY (CPF) REFERENCES Colaborador(CPF),
    FOREIGN KEY (Sala_virtual) REFERENCES Comite(Sala_virtual)
);
    
    

CREATE TABLE Corpo_cient (
    CPF CHAR(14),
    Id_proj INT,
    Cargo VARCHAR(255) NOT NULL,
    Carga_hor TIME NOT NULL,
    PRIMARY KEY (CPF),
    FOREIGN KEY (CPF) REFERENCES Colaborador(CPF),
    FOREIGN KEY (Id_proj) REFERENCES Projeto(Id_proj)
);

    
    
CREATE TABLE Coord (
    CPF CHAR(14),
    Id_proj INT,
    PRIMARY KEY (CPF),
    FOREIGN KEY (CPF) REFERENCES Colaborador(CPF),
    FOREIGN KEY (Id_proj) REFERENCES Projeto(Id_proj)   
);
    
    

CREATE TABLE Possui_local (
    Id_loc INT,
    Id_proj INT,
    Sede BOOL NOT NULL,
    PRIMARY KEY (Id_loc, Id_proj),
    FOREIGN KEY (Id_loc) REFERENCES Local_atv(Id_loc),
    FOREIGN KEY (Id_proj) REFERENCES Projeto(Id_proj)
);
    
    

CREATE TABLE Aprova_renova (
    Id_proj INT,
    Sala_virtual VARCHAR(255),
    PRIMARY KEY (Id_proj, Sala_virtual),
    FOREIGN KEY (Id_proj) REFERENCES Projeto(Id_proj),
    FOREIGN KEY (Sala_virtual) REFERENCES Comite(Sala_virtual)
);