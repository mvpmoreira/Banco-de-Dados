-- Dados fictícios para tabela pessoa_fisica
INSERT INTO pessoa_fisica (CPF, Nasc, Nome)
VALUES
('123.456.789-00', '1980-05-15', 'João da Silva'),
('987.654.321-00', '1995-10-25', 'Maria Souza'),
('111.222.333-44', '1972-03-08', 'Carlos Oliveira');

-- Dados fictícios para tabela pessoa_juridica
INSERT INTO pessoa_juridica (CNPJ, Nome_fantasia)
VALUES
('00.123.456/0001-00', 'Empresa A'),
('99.888.777/0001-99', 'Empresa B'),
('11.222.333/0001-11', 'Empresa C');

-- Dados fictícios para tabela locatario
INSERT INTO locatario (Conta, CPF, CNPJ, Agencia)
VALUES
('123456789-0', '123.456.789-00', '00.123.456/0001-00', 'Agência A'),
('987654321-9', '987.654.321-00', '99.888.777/0001-99', 'Agência B'),
('111222333-8', '111.222.333-44', '11.222.333/0001-11', 'Agência C');

-- Dados fictícios para tabela funcionario
INSERT INTO funcionario (Reg_func, CPF, CNPJ)
VALUES
('F001', '123.456.789-00', '00.123.456/0001-00'),
('F002', '987.654.321-00', '99.888.777/0001-99'),
('F003', '111.222.333-44', '11.222.333/0001-11');

-- Dados fictícios para tabela veiculo
INSERT INTO veiculo (Placa, Chassi, Dimensoes, Categoria, Marca, Cor, Modelo, Bebe_confort, Ar_cond, Mecaniz, Preco)
VALUES
('ABC1234', '123456789ABCDEF01', '4.5m x 1.8m x 1.6m', 'Passeio', 'Toyota', 'Pre', 'Corolla', 1, 1, 'Automático', 700),
('XYZ9876', '987654321FEDCBA09', '4.7m x 1.9m x 1.7m', 'Utilitário', 'Ford', 'Bra', 'Ranger', 1, 0, 'Manual', 200),
('DEF4567', '456789012BCDEFA23', '5.0m x 2.0m x 1.8m', 'SUV', 'Chevrolet', 'Prata', 'Tracker', 1, 1, 'Automático', 400);

-- Dados fictícios para tabela condutor
INSERT INTO condutor (CNH, CPF, Placa, Conta, Venc_CNH, Cond_princ)
VALUES
('12345678900', '123.456.789-00', 'ABC1234', '123456789', '2023-05-15', 1),
('98765432100', '987.654.321-00', 'XYZ9876', '987654321', '2024-07-20', 1),
('11122233344', '111.222.333-44', 'DEF4567', '111222333', '2023-12-31', 1);

-- Dados fictícios para tabela prontuario
INSERT INTO prontuario (Placa, Quilometragem, Revisao, Idade_vei, Est_conserv, Press_pneu, Niv_oleo)
VALUES
('ABC1234', 50000, 1, 5, 'Bom', 32.0, 4.5),
('XYZ9876', 80000, 0, 3, 'Regular', 30.5, 4.2),
('DEF4567', 30000, 1, 2, 'Novo', 35.0, 4.8);

-- Dados fictícios para tabela fila_espera
INSERT INTO fila_espera (Num_consul, Data_consul)
VALUES
(1, '2024-07-01 10:00:00'),
(2, '2024-07-02 14:30:00'),
(3, '2024-07-03 09:15:00');

-- Dados fictícios para tabela subsis_reserv
INSERT INTO subsis_reserv (Placa, Num_consul, Num_client)
VALUES
('ABC1234', 1, '0'),
('XYZ9876', 2, '5'),
('DEF4567', 3, '2');

-- Dados fictícios para tabela foto_ilus
INSERT INTO foto_ilus (Placa, Id_foto, Foto)
VALUES
('ABC1234', 1, 'Foto do veículo ABC1234'),
('XYZ9876', 2, 'Foto do veículo XYZ9876'),
('DEF4567', 3, 'Foto do veículo DEF4567');

-- Dados fictícios para tabela subsis_locacao
INSERT INTO subsis_locacao (Num_reserv, Placa, Conta, CPF, Seguros_ad, Data_retirada_prev, Data_retirada_efet, Data_compra, Data_devol_prev, Data_devol_efet, Patio_entra, Patio_saida)
VALUES
(1, 'ABC1234', '123456789', '123.456.789-00', 1, '2024-07-01 08:00:00', '2024-07-01 08:30:00', '2024-07-01', '2024-07-05 18:00:00', '2024-07-05 17:45:00', 'Pátio Aeroporto', 'Pátio Aeroporto'),
(2, 'XYZ9876', '987654321', '987.654.321-00', 0, '2024-07-02 09:00:00', '2024-07-02 09:30:00', '2024-07-02', '2024-07-07 17:00:00', '2024-07-07 16:45:00', 'Pátio Centro da Cidade', 'Pátio da Locadora'),
(3, 'DEF4567', '111222333', '111.222.333-44', 1, '2024-07-03 10:00:00', '2024-07-03 10:30:00', '2024-07-03', '2024-07-09 16:00:00', '2024-07-09 15:45:00', 'Pátio da Locadora', 'Pátio Centro da Cidade');

-- Inserindo novos dados de menores de 21 anos
INSERT INTO pessoa_fisica (CPF, Nasc, Nome)
VALUES
('111.456.789-00', '2005-05-15', 'João da Silva'),
('111.654.321-00', '2005-10-25', 'Maria Souza'),
('111.222.333-45', '2005-03-08', 'Carlos Oliveira');

INSERT INTO locatario (Conta, CPF, CNPJ, Agencia)
VALUES
('123456780', '111.456.789-00', NULL, 'Agência A'),
('987654320', '111.654.321-00', NULL, 'Agência B'),
('111222330', '111.222.333-45', NULL, 'Agência C');

INSERT INTO condutor (CNH, CPF, Placa, Conta, Venc_CNH, Cond_princ)
VALUES
('12345678901', '111.456.789-00', 'ABC1234', '123456780', '2023-05-15', 0),
('98765432101', '111.654.321-00', 'XYZ9876', '987654320', '2024-07-20', 0),
('11122233341', '111.222.333-45', 'DEF4567', '111222330', '2023-12-31', 0);

-- Inserindo reserva com atraso na devolução
INSERT INTO subsis_locacao (Num_reserv, Placa, Conta, CPF, Seguros_ad, Data_retirada_prev, Data_retirada_efet, Data_compra, Data_devol_prev, Data_devol_efet, Patio_entra, Patio_saida)
VALUES
(4, 'ABC1134', '123456789', '123.456.789-0', 1, '2024-07-01 08:00:00', '2024-07-01 08:30:00', '2024-07-01', '2024-07-05 18:00:00', '2024-07-07 17:45:00', 'Pátio Aeroporto', 'Pátio Aeroporto');

INSERT INTO veiculo (Placa, Chassi, Dimensoes, Categoria, Marca, Cor, Modelo, Bebe_confort, Ar_cond, Mecaniz, Preco)
VALUES
('AAA1234', '123452789ABCDEF01', '3.5m x 1.8m x 1.6m', 'Passeio', 'Toyota', 'Pre', 'Etios', 1, 1, 'Automático', 500);

INSERT INTO prontuario (Placa, Quilometragem, Revisao, Idade_vei, Est_conserv, Press_pneu, Niv_oleo)
VALUES
('AAA1234', 65000, 0, 5, 'Regular', 32.0, 4.5);

INSERT INTO fila_espera (Num_consul, Data_consul)
VALUES
(4, '2024-07-01 10:00:00');

INSERT INTO subsis_reserv (Placa, Num_consul, Num_client)
VALUES
('AAA1234', 4, '0');