-- homework 1 behavioral model

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity homework_1behav is 
	port (
			F3		: out std_logic;
			F2		: out std_logic;
			F1		: out std_logic;
			F0		: out std_logic;
			
			A		: in std_logic;
			B		: in std_logic;
			C		: in std_logic;
			D		: in std_logic
		);
end homework_1behav;

architecture behavior of homework_1behav is 
	signal inputs		: std_logic_vector(3 downto 0);
	signal outputs		: std_logic_vector(3 downto 0);
	begin
	inputs <= A & B & C & D;
	
	F3 <= outputs(3);
	F2 <= outputs(2);
	F1 <= outputs(1);
	F0 <= outputs(0);
	
	hw1_proc : process(inputs)
	begin
			case inputs is
				when "0000" =>
					outputs <= "1101";
				when "0001" =>
					outputs <= "0111";
				when "0010" =>
					outputs <= "1001";
				when "0011" =>
					outputs <= "1111";
				when "0100" =>
					outputs <= "0000";
				when "0101" =>
					outputs <= "1111";
				when "0110" =>
					outputs <= "0100";
				when "0111" =>
					outputs <= "1010";
				when "1000" =>
					outputs <= "0101";
				when "1001" =>
					outputs <= "0111";
				when "1010" =>
					outputs <= "1011";
				when "1011" =>
					outputs <= "1000";
				when "1100" =>
					outputs <= "0100";
				when "1101" =>
					outputs <= "1010";
				when "1110" =>
					outputs <= "1011";
				when "1111" =>
					outputs <= "0101";
				when others =>
				    outputs <= "XXXX";   -- dont care combinations
			end case;
		end process hw1_proc;
	end behavior;
 		