----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    01:12:34 05/13/2022 
-- Design Name: 
-- Module Name:    one - Behavioral 
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
 use IEEE.std_logic_unsigned.all; 
 use IEEE.numeric_std.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity one is port ( entr: in std_logic_vector (15 downto 0 ) ;
							sort: out std_logic_vector (15 downto 0 ) ); 
end one;

architecture Behavioral of one is 
begin  
process(entr) 

begin 
sort<=std_logic_vector(to_unsigned(to_integer(unsigned(entr))+1,16));

end process ; 



end Behavioral;

