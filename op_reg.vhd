----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:48:11 05/13/2022 
-- Design Name: 
-- Module Name:    op_reg - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity op_reg is port ( ent : in std_logic_vector( 15 downto 0 ) ; 
						rst, clk : in std_logic ;
						srt : out std_logic_vector( 15 downto 0 )); 
end op_reg;

architecture Behavioral of op_reg is   
begin
process(rst,clk)
begin  
if rst='1' then srt<=x"0000"; 
elsif (clk' event and clk='1') then 
srt<=ent ; 
end if ; 
end process ; 
end Behavioral;

