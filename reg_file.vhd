-------------------------------------------------------------------------------
-- 64 x 16 bits register file
--
-- Ports:
--   - clk [in]  : clock signal
--   - rst [in]  : reset signal
--
--   - acc_out [out] : accumulator value
--   - acc_ce  [in]  : accumulator clock enable signal
--
--   - pc_out [out] : program counter value
--   - pc_ce  [in]  : program counter clock enable signal
--   - rpc_ce [in]  : return program counter clock enable signal
--
--   - rx_num [in]  : register number
--   - rx_out [out] : register value
--   - rx_ce  [in]  : register clock enable signal
--
--   - din [in]  : input value
--
--        ______________
--   R0  |________________| Accumulator (Acc)
--   R1  |________________|
--   R2  |________________|
--          .    .    .
--        ______________
--   R61 |________________|
--   R62 |________________| Return program counter (RPC)
--   R63 |________________| Program counter (PC)
--
-- The PC has to be reset to 0xA000 to account for the video memory sitting
-- on addresses from 0x0000 to 0x9FFF.
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;


entity reg_file is
  port ( clk : in  std_logic;
         rst : in  std_logic;

         acc_out : out std_logic_vector(15 downto 0);
         acc_ce  : in  std_logic;

         pc_out : out std_logic_vector(15 downto 0);
         pc_ce  : in  std_logic;
         rpc_ce : in  std_logic;

         rx_num : in  std_logic_vector(5 downto 0);
         rx_out : out std_logic_vector(15 downto 0);
         rx_ce  : in  std_logic;

         din : in  std_logic_vector(15 downto 0) );
end entity;

architecture arch of reg_file is
type tableau is array(0 downto 63) of std_logic_vector(15 downto 0);
signal tab : tableau;
signal sel:integer;
begin
process(rst,clk)
begin
if (rst = '1') then
	f1 : for i in 0 to 63 loop
           tab(i)   <= x"0000";
			  end loop f1 ;
			
elsif (clk' event and clk = '1') then
sel <= to_integer(unsigned(rx_num));
if (acc_ce <= '1') then tab(0) <= din;
elsif (pc_ce='1')then tab(63) <= din;
elsif (rpc_ce='1')then tab(62) <= din;
elsif (rx_ce='1')then tab(sel) <= din;
end if;

acc_out<=tab(0);
pc_out<=tab(63);
f2 : for i in 0 to 63 loop
	if (sel = i)then
        rx_out   <= tab(sel);
	end if;
end loop f2;
end if;
end process;
end architecture;