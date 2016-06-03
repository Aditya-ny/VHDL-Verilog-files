-- data flow design
-- 
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity homework_1dataflow is
	port (
			F3		: out std_logic;   -- output
			F2		: out std_logic;	-- output
			F1		: out std_logic;	-- output
			F0		: out std_logic;	-- output
			
			A		: in std_logic;		-- input
			B		: in std_logic;		-- input
			C		: in std_logic;		-- input
			D		: in std_logic);	-- input

	end homework_1dataflow;

architecture dataflow of homework_1dataflow is
begin

F0 <= (not A and not B) or (not B and not C) or (not B and not D) or (A and B and C) or (not A and not C and D);
F1 <= (not C and D) or (not A and D) or (A and C and not D);
F2 <= (not B and not C) or (A and not C and not D) or (not A and not C and D) or (not A and not B and D) 
           or (not A and B and C and not D) or (A and B and C and D);
F3 <= (not B and C) or ( B and not C and D) or (not A and B and D) or (A and C and not D) or (not A and not B and not D);
		   



end dataflow;
	