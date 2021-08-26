library ieee;

use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity debounce is
	generic(
		debounce_time	: integer :=200000	
	
	);
	
	port(
		clk		: in std_logic;
		pin		: in std_logic;
		pout 		: out std_logic;
		f_edge   	: out std_logic
		);
end debounce;
	
architecture basic of debounce is
	signal count_int	: std_logic_vector(25 downto 0);
	signal p1 : std_logic;
	signal p2 : std_logic;
begin	
	process(clk)
	begin
	if rising_edge(clk) then
		p2 <= p1;
		p1 <= pin;
		
		if (p1 xor p2) = '1' then
			count_int <= (others => '0');  -- RES			
		elsif count_int < debounce_time then
			count_int <= count_int + 1;    -- COUNT
		elsif count_int < debounce_time + 1 then
			pout <= p2;                    -- LATCH
			count_int <= count_int + 1;
			if p2 = '0' then
				f_edge <= '1';
			end if;
		else
			f_edge <= '0';                 -- WAIT
		end if;
	
			
	end if;
		
	end process;
	
end basic;