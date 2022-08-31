library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity alu is
    Port ( op : in  std_logic_vector(3 downto 0);
         i1 : in  std_logic_vector(15 downto 0);
         i2 : in  std_logic_vector(15 downto 0);
         o  : out std_logic_vector(15 downto 0);
         st : out std_logic_vector(3 downto 0));
end entity;

architecture Behavioral of alu is
signal result : std_logic_vector(16 downto 0);
signal Z, N, C, V : std_logic;
begin
process(op,i1,i2)
begin
case (op) is
when "0000" =>result <='0'&(i1 and i2);
when "0001" =>result <='0'&(i1 or i2);
when "0010" =>result <='0'&(i1 xor i2);
when "0011" => result <= '0'&not(i2);
when "0100" =>result <='0'&(i1 + i2);
when "0101" =>result <='0'&(i1 - i2);
when "0110" =>result <= std_logic_vector(shift_left(signed('0'&i1), to_integer(signed('0'&i2))));   
when "0111" =>result <= std_logic_vector(shift_right(signed('0'&i1), to_integer(signed('0'&i2))));
when "1000" =>result <= '0'&i2;
when "1001" =>result <= '0'&i1;
when "1010" =>result <= '0'&i2;
when "1011" =>result <= '0'&i1;
when "1100" =>result <= '0'&(i1 + i2);   
when "1101" =>result <= '0'&(i1 - i2);
when "1110" =>result <= '0'&i2;    
when others => null;
end case;
end process;
o <= result(15 downto 0);
Z <= '1' when (signed(result(15 downto 0)) = x"FFFF") else '0';
N <= '1' when (result(15)='1') else '0';
C <= result(16);
V <= result(15);
st<= Z&N&C&V;
end Behavioral;