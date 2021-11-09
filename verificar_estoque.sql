CREATE OR REPLACE FUNCTION verifica_estoque (p_id_produto INTEGER, p_qtde INTEGER) RETURNS VARCHAR AS $$

    DECLARE v_qtde integer;
    DECLARE v_preco NUMERIC(7,2);
    DECLARE v_msg VARCHAR;

BEGIN
    -- verificar quantidade em estoque
    v_qtde := (SELECT v_qtde
               FROM p_id_produto
               WHERE id_produto = p_id_produto );

    IF(v_qtde < p_qtde) THEN
        v_msg := 'ESTOQUE INSUFICIENTE!';
    
    ELSE
        v_msg := 'ESTOQUE DISPONIVEL';
    END IF;

END;
$$ LANGUAGE plpgsql;


