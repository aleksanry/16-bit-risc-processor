----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:06:14 05/13/2022 
-- Design Name: 
-- Module Name:    mux2 - Behavioral 
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

entity mux1 is
        port (In0, In1 : in std_logic_vector (15 downto 0);
        Sel: in std_logic;
                   Z: out std_logic_vector (15 downto 0));
end mux1;
architecture Behavioral of mux1 is
begin 
process(In0, In1,Sel) 
begin
--z <= In0  when Sel:='00' else
--         In1  when Sel :='01'  else
--         In2  when Sel :='10' else
--         “00000000”; 
if (Sel='0') then 
z<=In0;  
elsif (Sel='1') then 
z<=In1;  
  


end if ; 
end process ; 
end Behavioral;


