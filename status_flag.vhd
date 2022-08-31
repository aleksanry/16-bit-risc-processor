-------------------------------------------------------------------------------
-- 4-bit status register
--
-- Ports:
--   - clk [in]  : clock signal
--   - ce  [in]  : clock enable signal
--   - rst [in]  : reset signal
--
--   - i [in]  : status flags from ALU
--   - o [out] : latched status flags
--
--   

-- Bit #  | 3| 2| 1| 0|
--        |__|__|__|__|
--          Z  N  C  V
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity status_reg is
  port ( clk : in  std_logic;
         ce  : in  std_logic;
         rst : in  std_logic;
			i : in  std_logic_vector(3 downto 0);
         o : out std_logic_vector(3 downto 0) );
end entity;

architecture arch of status_reg is
begin

process(clk,rst)
begin 
if (rst = '1') then o <= (others => '0'); 
elsif ( clk' event and clk = '1') then  
	if (ce = '1') then o <= i ; 
	end if ; 
end if ;  
end process ; 
end architecture;  