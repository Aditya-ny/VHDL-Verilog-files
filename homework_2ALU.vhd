-- Homework #2
--A_inLU 
-- entity declaration

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity homework_2ALU is 
generic (
		bit_depth		: integer := 32 );
port (
			result		: out std_logic_vector(bit_depth-1 downto 0);
			Error		: out std_logic;
			A			: in std_logic_vector(bit_depth-1 downto 0);
			B			: in std_logic_vector(bit_depth-1 downto 0);
			Opcode		: in std_logic_vector(3 downto 0)
			);
	end homework_2ALU;
architecture behavior of homework_2ALU is

--signal result  <= signed(bit_depth-1 downto 0); 
signal A_in : signed(bit_depth-1 downto 0);
signal B_in  : signed(bit_depth-1 downto 0);

begin
A_in <= signed(A);
B_in <= signed(B);


	
	state_op: process(Opcode, A_in, B_in)
	begin 
	error <= '0';
	--result <= signed(result); 
	--output A (0)
	
	if(Opcode = "0000") then 
		result <= std_logic_vector(A_in);
	-- for output B (1)
	elsif(Opcode = "0001") then 
		result <= std_logic_vector(B_in);
	-- for output A+B	(2)
	elsif(Opcode = "0010") then 
		result <= std_logic_vector(A_in + B_in);
	-- for output A-B (3)
	elsif(Opcode = "0011") then
		result <= std_logic_vector(A_in - B_in);
	-- for output Not A (4)
	elsif(Opcode = "0100") then 
		result <= Not  std_logic_vector(A_in);
	-- for output Not B (5)
	elsif(Opcode = "0101") then
		result <= Not std_logic_vector(B_in);
	-- for output Shift A left by 2 bits(mult. by 4) (6)
	-- sll for shift left in the form A L sll R where L is the left operand 
	-- A and R is the number of times the shift is to be done
	elsif(Opcode = "0110") then
		result <= std_logic_vector(A_in sll 2);
	-- now right shift	(7)
	elsif(Opcode = "0111") then
		result <= std_logic_vector(A_in srl 2);
	--	now left shift of B (8)
	elsif(Opcode = "1000") then
		result <= std_logic_vector(B_in sll 2);
	-- now right shift by 2 (9)
	elsif(Opcode = "1001") then
		result <= std_logic_vector(B_in srl 2);
	--	now bitwise A and B 10
	elsif(Opcode = "1010") then
		result <= std_logic_vector(A_in) and std_logic_vector(B_in);
	-- now bitwise A OR B 11
	elsif(Opcode = "1011") then
		result <= std_logic_vector(A_in) or std_logic_vector(B_in);
	-- now for others
	else
		result <= (others => 'X');
		error <= '1';
	end if;
end process;	


end behavior;

	