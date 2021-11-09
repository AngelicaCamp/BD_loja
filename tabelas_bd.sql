CREATE TABLE produto (
	id SERIAL NOT NULL,
	descricao CHARACTER VARYING (80) NOT NULL,
	preco NUMERIC(7,2) NOT NULL,
	qt_estoque INTEGER NOT NULL,
	qt_min INTEGER NOT NULL,
	qt_max INTEGER NOT NULL,
	CONSTRAINT produto_pk PRIMARY KEY(id)
);

CREATE TABLE venda (
	id SERIAL NOT NULL,
	data TIMESTAMP WITHOUT TIME ZONE DEFAULT NOW(),
	total NUMERIC(7,2)DEFAULT 0,
	id_vendedor INTEGER NOT NULL,
	CONSTRAINT venda_pk PRIMARY KEY(id),
	CONSTRAINT fk_vendedor FOREIGN KEY (id_vendedor) REFERENCES vendedor (id_vendedor)
);

CREATE TABLE item_venda (
	id_venda INTEGER NOT NULL,
	id_produto INTEGER NOT NULL,
	qtde INTEGER NOT NULL DEFAULT 1,
	preco NUMERIC(7,2) NOT NULL DEFAULT 0,
	subtotal NUMERIC(7,2) NOT NULL DEFAULT 0,
	CONSTRAINT item_venda_pk PRIMARY KEY(id_venda,id_produto),
	CONSTRAINT id_produto_fk FOREIGN KEY (id_produto) REFERENCES produto(id) MATCH SIMPLE
	ON UPDATE NO ACTION ON DELETE NO ACTION,
	
	CONSTRAINT id_venda_fk FOREIGN KEY (id_venda) REFERENCES venda(id) MATCH SIMPLE
	ON UPDATE NO ACTION ON DELETE NO ACTION
);

CREATE TABLE vendedor (
    id_vendedor SERIAL primary key,
    nome_completo VARCHAR(80) NOT NULL,
    salario_fixo NUMERIC(7,2) NOT NULL DEFAULT 0.0
);

CREATE TABLE folha_pgto (
    id_pgto SERIAL PRIMARY KEY NOT NULL,
    id_vendedor INTEGER NOT NULL,
    FOREIGN KEY (id_vendedor) REFERENCES vendedor (id_vendedor)
);






