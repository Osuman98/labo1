-------------------------------------------------------------------------------
--
-- vote_labo1.vhd
--
-- Le problème du vote secret.
--
-- Chacune des entrées 'lesvotes' représente le vote secret d'une personne, oui ('1') ou non ('0').
-- La sortie 'approbation' indique si une majorité (50% + 1) de personnes a voté oui.
--
-- v. 1.0 2020-06-30 Pierre Langlois
-- v. 1.1 *** CETTE VERSION COMPORTE DES ERREURS DE SYNTAXE ET DES ERREURS FONCTIONELLES ***
--
-------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity vote_labo1 is
	generic (
		W : positive := 4
	)
	port (	 
		lesvotes: in std_logic(W - 1 downto 0)
		approbation : out std_logic
	);
end vote_labo;-

architecture flotdonnees of vote is  
begin
    
    assert W = 4 report "cette architecture n'est valide que pour W = 4" severity failure;
    
	with lesvotes select
		approbation <=
			'1' when "0111",
			'1' when "1101",
			'1' when "1110",
			'0' when others;
end arch;