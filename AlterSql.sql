-- Script para alterar estruturas das tabelas

ALTER TABLE pedidos 
	CHANGE COLUMN valor_total valor_total DECIMAL(7,2) UNSIGNED ZEROFILL NOT NULL ;
    
ALTER TABLE Funcionario
 ADD salario DECIMAL(10,2);
 
ALTER TABLE Cargo
 MODIFY descricao_cargo VARCHAR(255);
 
ALTER TABLE Telefone_funcionario
 ADD CONSTRAINT fk_telefone_funcionario
  FOREIGN KEY (Funcionario_CPF) REFERENCES Funcionario(CPF);
  
ALTER TABLE Cliente
 ADD sexo ENUM('Masculino', 'Feminino', 'Outro');
 
ALTER TABLE Funcionario
 ADD data_contratacao DATE;
 
ALTER TABLE Endereco_cliente
 ADD CONSTRAINT fk_endereco_cliente
  FOREIGN KEY (Cliente_id_Cliente) REFERENCES Cliente(id_Cliente);
  
ALTER TABLE Funcionario
 ADD formacao VARCHAR(100);
 
ALTER TABLE Exemplares
 ADD estoque_minimo INT DEFAULT 1;
 
ALTER TABLE Departamento
 ADD CONSTRAINT fk_departamento_cargo
  FOREIGN KEY (Cargo_id_Cargo) REFERENCES Cargo(id_Cargo);









