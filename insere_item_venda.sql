CREATE OR REPLACE FUNCTION insere_item_venda(p_id_venda INTEGER, p_id_produto INTEGER, p_qtde INTEGER) 
 RETURNS INTEGER AS $$
	DECLARE v_preco numeric(7,2);
	DECLARE v_total numeric(7,2);
BEGIN
 -- Consulta o preço
	 SELECT preco INTO v_preco 
	 FROM produto 
	 WHERE id = p_id_produto;

	 -- Insere o item de venda, registra o preco e calcula o subtotal
	 INSERT INTO item_venda (id_venda, id_produto, preco, qtde, subtotal) 
	  VALUES (p_id_venda, p_id_produto, v_preco, p_qtde, p_qtde * v_preco);

	 -- Baixa do estoque
	 UPDATE produto 
	 SET qt_estoque = qt_estoque - p_qtde 
	 WHERE id = p_id_produto;

	 -- Atualiza total de venda
	 SELECT SUM(subtotal) INTO v_total 
	 FROM item_venda 
	 WHERE id_venda = p_id_venda;
	 
	 UPDATE venda 
	 SET total = v_total 
	 WHERE id = p_id_venda;

	 RETURN 1;
END;
$$ LANGUAGE plpgsql;



