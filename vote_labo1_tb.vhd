---------------------------------------------
--
-- vote_labo1_tb
--
-- Banc d'essai pour le module vote_labo1
-- La sortie 'approbation' doit avoir une valeur de '1' quand plus de la moiti� des entr�es 'lesvotes' ont une valeur de '1',
-- sinon elle doit avoir une valeur de '0'.
--
-- v. 1.0 2020-06-30 Pierre Langlois
--
-------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.numeric_std.all;
use work.all;

entity vote_labo1_tb is
	generic (
		W_tb : positive := 4
	);
end entity;

architecture arch of vote_labo1_tb is
	
signal lesvotes_tb : std_logic_vector(W_tb - 1 downto 0);
signal approbation_tb : std_logic;

function majorite (V: std_logic_vector) return boolean is
variable compte : natural := 0;
begin
	for i in V'range loop
        if V(i) = '1' then
		    compte := compte + 1;
        end if;
	end loop;
    return compte > V'length / 2;
end;

begin

	-- instanciation du module � v�rifier UUT (Unit Under Test)
	UUT : entity vote_labo1(flotdonnees)
        generic map (W => W_tb)
        port map (lesvotes => lesvotes_tb, approbation => approbation_tb);
	
	-- application exhaustive des vecteurs de test, affichage et v�rification
    process
	begin
		for k in 0 to 2 ** W_tb - 1 loop
			lesvotes_tb <= std_logic_vector(to_unsigned(k, W_tb));
			wait for 10 ns; -- n�cessaire pour que les signaux se propagent dans l'UUT

			
-- code valide uniquement pour la version 2008 et 2018 de VHDL
-- (la fonction to_string n'est pas d�finie dans VHDL v. 2002)
			report "k: " & to_string(k)
                & ", lesvotes_tb : " & to_string(lesvotes_tb)
                & ", approbation_tb : " & to_string(approbation_tb);
            assert ((approbation_tb = '1') = majorite(lesvotes_tb)) report "erreur pour l'entr�e " & to_string(k) severity error;

-- code valide pour la version 2002 de VHDL, mais moins expressif
--            assert ((approbation_tb = '1') = majorite(lesvotes_tb)) report "erreur pour l'entr�e " & integer'image(k) severity error;
		end loop; 
		
        report "simulation termin�e" severity failure;
		
	end process;
	
end arch;