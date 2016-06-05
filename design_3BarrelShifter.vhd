-- Barrel Shifter 
library IEEE;
use IEEE.STD_logic_1164.all;
use IEEE.numeric_std.all;

entity desgin_homework_3BS is 
generic (
bit_depth	: integer := 8);
port(
A		: out std_logic_vector(bit_depth-1 downto 0);
I 		: in std_logic_vector(bit_depth-1 downto 0);
S 		: in std_logic_vector(1 downto 0);
shift	: in integer range 0 to bit_depth-1;
reset	: in std_logic;
clk 	: in std_logic);

end desgin_homework_3BS;
architecture behavior of desgin_homework_3BS is 


signal A_reg		: std_logic_vector(bit_depth-1 downto 0);
begin
	A <= A_reg;
	
	desgin_homework_3BS_porc: process(clk, reset)
	begin
		if(rising_edge(clk)) then
		if(reset = '0') then
		A_reg <= (others => '0');
		else
		case S is 
		when "00" => -- for hold
		A_reg <= A_reg;
		
		when "01" => -- for shift right 
		
		case shift is
		
		when 0 =>
		A_reg <= A_reg ;
		
		
		when 1 =>
		A_reg(bit_depth-1) <= A_reg(0);
		A_reg(bit_depth-2 downto 0) <= A_reg(bit_depth-1 downto 1);
		
		when 2 =>
		
		A_reg(bit_depth-1) <= A_reg(0);
		A_reg(bit_depth-2) <= A_reg(1);
		A_reg(bit_depth-3 downto 0) <= A_reg(bit_depth-1 downto 2);
		
		
		
		when 3 =>
		A_reg(bit_depth-1) <= A_reg(0);
		A_reg(bit_depth-2) <= A_reg(1);
		A_reg(bit_depth-3) <= A_reg(2);
		
		A_reg(bit_depth-4 downto 0) <= A_reg(bit_depth-1 downto 3);
		
		
		when 4 =>
		A_reg(bit_depth-1) <= A_reg(0);
		A_reg(bit_depth-2) <= A_reg(1); A_reg(bit_depth-3) <= A_reg(2); A_reg(bit_depth-4) <= A_reg(3);
		
		A_reg(bit_depth-5 downto 0) <= A_reg(bit_depth-1 downto 4);
		
		
		when others =>
		A_reg <= (others => 'X');
		
		end case;
		
		
		when "10" => -- for left shift
		
		case shift is
		
		
		when 0 =>
		A_reg <= A_reg;
		
		
		when 1 =>
		
		A_reg(0) <= A_reg(bit_depth-1);
		A_reg(bit_depth-1 downto 1) <= A_reg(bit_depth-2 downto 0);
		
		
		when 2 =>
		A_reg(0) <= A_reg(bit_depth-1); A_reg(1) <= A_reg(bit_depth-2);
		A_reg(bit_depth-1 downto 2) <= A_reg(bit_depth-3 downto 0);
		
		
		when 3 =>
		A_reg(0) <= A_reg(bit_depth-1); A_reg(1) <= A_reg(bit_depth-2); A_reg(2) <= A_reg(bit_depth-3);
		
		A_reg(bit_depth-1 downto 3) <= A_reg(bit_depth-4 downto 0);
		
		
		when 4 =>
		
		A_reg(0) <= A_reg(bit_depth-1); A_reg(1) <= A_reg(bit_depth-2); A_reg(2) <= A_reg(bit_depth-3); A_reg(3) <= A_reg(bit_depth-4);
		A_reg(bit_depth-1 downto 4) <= A_reg(bit_depth-5 downto 0);
		
		
		when others =>
		
		A_reg <= (others => 'X');
		
		end case;
		
		when "11" =>
		A_reg <= I;
		
		when others =>
		A_reg <= (others => 'X');
		
		end case;
		end if;
		end if;
		end process desgin_homework_3BS_porc;
		end behavior;

		
		
		



