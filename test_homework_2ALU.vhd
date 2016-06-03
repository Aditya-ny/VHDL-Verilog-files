-- testbench for ALU. 9:00 PM
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.math_real.all;


entity test_homework_2ALU is
end;

architecture test of test_homework_2ALU is
	

component homework_2ALU
generic (
		bit_depth		: integer := 32 );
	port (
			result		: out std_logic_vector(bit_depth-1 downto 0);
			Error		: out std_logic;
			A			: in std_logic_vector(bit_depth-1 downto 0);
 			B			: in std_logic_vector(bit_depth-1 downto 0);
			Opcode		: in std_logic_vector(3 downto 0)
			);
	end component;
	
	constant bit_depth : integer := 32;
	constant max_input_value	: integer:= 2**(bit_depth-2);
	constant mid_point			: integer := max_input_value /2;
	
signal	A_in			: signed(bit_depth-1 downto 0) := (others => '0');
signal	B_in			: signed(bit_depth-1 downto 0) := (others => '0');

signal	Error_out		: std_logic;
signal	Opcode_in		: std_logic_vector(3 downto 0) := (others => '0');

--	
signal  result_out		: signed(bit_depth-1 downto 0);
--


begin
		dev_to_test: homework_2ALU 
		generic map(bit_depth => bit_depth)
		port map(
		signed(result) => result_out,
		Error => Error_out,
		A => std_logic_vector(A_in),
		B => std_logic_vector(B_in),
		Opcode => Opcode_in);
	
	expected_proc : process(Opcode_in)
	--stimulus : process
	begin
			case Opcode_in is
			when "0000" => result_out <= A_in;
			when "0001" => result_out <= B_in;
			when "0010" => result_out <= A_in+B_in;
			when "0011" => result_out <= A_in-B_in;
			when "0100" => result_out <= Not A_in;
			when "0101" => result_out <= Not B_in;
			when "0110" => result_out <= A_in sll 2;
			when "0111" => result_out <= A_in srl 2;
			when "1000" => result_out <= B_in sll 2;
			when "1001" => result_out <= B_in srl 2;
			when "1010" => result_out <= A_in and B_in;
			when "1011" => result_out <= A_in or B_in;
			when others => result_out <= (signed(result) => 'X');
		end case;
	end process expected_proc;
stimulus : process
	variable ErrCnt : integer := 0;
	--variable WriteBuf	: line ;
	variable seed1, seed2		: positive; -- Seed values for random generator
	variable rand, rval			: real; 
	
	begin 
	for i in 0 to 13 loop
	Opcode_in <= std_logic_vector(to_unsigned(i,4));
	for j in 0 to 13 loop
		UNIFORM(seed1, seed2, rand); -- for a  random number
		rval := trunc(rand*real(max_input_value));
		A_in <= to_signed(integer(rval)-mid_point,bit_depth);
		
		UNIFORM(seed1, seed2, rand); -- for a random number
		rval := trunc(rand*real(max_input_value));
		B_in <= to_signed(integer(rval)-mid_point,bit_depth);
	
	
	
	wait for 10 ns;
	if(result_out /= signed(result)) then 
	write(WriteBuf, string'("Error ALU test failed at result_out : "));
	write(WriteBuf, std_logic_vector(A_in)); 
	write(WriteBuf, string'(", B ="));
	write(WriteBuf, std_logic_vector(B_in)); 
	write(WriteBuf, string'(", Opcode ="));
	write(WriteBuf, Opcode_in);
	
	writeline(Output, WriteBuf);
	ErrCnt := ErrCnt+1;
	end if;
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	--if(Error_out /= Error) then 
	--write(WriteBuf, string'("Error ALU test failed at result_out : "));
	--write(WriteBuf, A_in); write(WriteBuf, string'(", B ="));
	--write(WriteBuf, B_in); write(WriteBuf, string'(", Opcode ="));
	--write(WriteBuf, Opcode_in);
	
	--writeline(Output, WriteBuf);
	--ErrCnt := ErrCnt+1;
	--end if;
	
	end loop;
	end loop;
	
	
	if (ErrCnt = 0) then
	report "Success. the homework for ALU is completed";
	else 
	report " the ALU is broken. " severity warning;
	end if;
	--end procedure stimulus;
	end process;
	end test;
	
	