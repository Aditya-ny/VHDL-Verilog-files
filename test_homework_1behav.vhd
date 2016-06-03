-- test bench:::: for homework_1behav.vhd

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use std.textio.all;
use ieee.std_logic_textio.all;

entity test_homework_1behav is
end;

architecture test of test_homework_1behav is

component homework_1behav
	port (
			F3		: out std_logic;
			F2		: out std_logic;
			F1		: out std_logic;
			F0		: out std_logic;
			
			A		: in std_logic;
			B		: in std_logic;
			C		: in std_logic;
			D		: in std_logic);
	end component;
	
    signal F3_out		: std_logic;
	signal F2_out		: std_logic;
	signal F1_out		: std_logic;
	signal F0_out		: std_logic;
	signal A_in			: std_logic;
	signal B_in			: std_logic;
	signal C_in			: std_logic;
	signal D_in			: std_logic;
	
	signal F3_out_expected		: std_logic;
	signal F2_out_expected		: std_logic;
	signal F1_out_expected		: std_logic;
	signal F0_out_expected		: std_logic;
	
	signal inputs		: std_logic_vector(3 downto 0);
	signal outputs		: std_logic_vector(3 downto 0);
	
	begin
		dev_to_test : homework_1behav 
		port map (
		F3 => F3_out, F2 => F2_out, F1 => F1_out, F0 => F0_out,
		
	A => A_in, B => B_in, C => C_in, D => D_in);
	-- inputs 
	inputs <= A_in & B_in & C_in & D_in;
	-- outputs 
	F3_out_expected <= outputs(3);
	F2_out_expected <= outputs(2);
	F1_out_expected <= outputs(1);
	F0_out_expected <= outputs(0);
	
	expected_proc : process(inputs)
		begin
			case inputs is
			when "0000" => outputs <= "1101";
			when "0001" => outputs <= "0111";
			when "0010" => outputs <= "1001";
			when "0011" => outputs <= "1111";
			when "0100" => outputs <= "0000";
			when "0101" => outputs <= "1111";
			when "0110" => outputs <= "0100";
			when "0111" => outputs <= "1010";
			when "1000" => outputs <= "0101";
			when "1001" => outputs <= "0111";
			when "1010" => outputs <= "1011";
			when "1011" => outputs <= "1000";
			when "1100" => outputs <= "0100";
			when "1101" => outputs <= "1010";
			when "1110" => outputs <= "1011";
			when "1111" => outputs <= "0101";
			when others => outputs <= (others => 'X');
		end case;
	end process expected_proc;

stimulus : process
	
variable ErrCnt : integer := 0;
variable WriteBuf : line ;

begin 
for i in std_logic range '0' to '1' loop
A_in <= i;
for j in std_logic range '0' to '1' loop
B_in <= j;
for k in std_logic range '0' to '1' loop
C_in <= k;
for l in std_logic range '0' to '1' loop
D_in <= l;

	wait for 10 ns;
	if (F3_out_expected /= F3_out) then
		write(WriteBuf, string'(" Error logic failed at F3_out : A ="));
		write(WriteBuf, A_in); 
		write(WriteBuf, string'(", B ="));
		write(WriteBuf, B_in); 
		write(WriteBuf, string'(", C ="));
		write(WriteBuf, C_in);
		write(WriteBuf, string'(", D ="));
		write(WriteBuf, D_in);
		
		writeline(output, WriteBuf);
		ErrCnt := ErrCnt+1;
		end if;
		
	if (F2_out_expected /= F2_out) then
		write(WriteBuf, string'(" Error logic failed at F2_out : A ="));
		write(WriteBuf, A_in); 
		write(WriteBuf, string'(", B ="));
		write(WriteBuf, B_in); 
		write(WriteBuf, string'(", C ="));
		write(WriteBuf, C_in);
		write(WriteBuf, string'(", D ="));
		write(WriteBuf, D_in);	
		
		writeline(output, WriteBuf);
		ErrCnt := ErrCnt+1;
		end if;
		
	if (F1_out_expected /= F1_out) then
		write(WriteBuf, string'(" Error logic failed at F1_out : A ="));
		write(WriteBuf, A_in); 
		write(WriteBuf, string'(", B ="));
		write(WriteBuf, B_in); 
		write(WriteBuf, string'(", C ="));
		write(WriteBuf, C_in);
		write(WriteBuf, string'(", D ="));
		write(WriteBuf, D_in);
		
		writeline(output, WriteBuf);
		ErrCnt := ErrCnt+1;
	end if;	
	if (F0_out_expected /= F0_out) then
		write(WriteBuf, string'(" Error logic failed at F0_out : A ="));
		write(WriteBuf, A_in); 
		write(WriteBuf, string'(", B ="));
		write(WriteBuf, B_in); 
		write(WriteBuf, string'(", C ="));
		write(WriteBuf, C_in);
		write(WriteBuf, string'(", D ="));
		write(WriteBuf, D_in);
		
		writeline(output, WriteBuf);
		ErrCnt := ErrCnt+1;	
	end if;
end loop;
end loop;
end loop;
end loop;

if (ErrCnt = 0) then
report "Success. the homework_1behav is completed";
else 
report "homework_1behav is broken " severity warning;
end if;
end process stimulus;
end test;
 




	