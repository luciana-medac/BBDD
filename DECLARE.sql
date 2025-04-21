DECLARE
	nota NUMBER := 7.5;
	resultado VARCHAR2(20);
BEGIN
	CASE
		WHEN nota < 5 THEN
			resultado := 'Suspenso';
		WHEN nota >= 5 AND nota < 7 THEN
			resultado := 'Aprobado';
		WHEN nota >= 7 AND nota < 9 THEN
			resultado := 'Notable';
		WHEN nota >= 9 THEN
			resultado := 'Sobresaliente';
		ELSE 
			resultado := 'nota no valida';
	END CASE;
	dbms_output.put_line('Resultado: ' || resultado
END;