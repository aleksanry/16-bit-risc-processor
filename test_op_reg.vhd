--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   00:56:45 05/13/2022
-- Design Name:   
-- Module Name:   /home/maddouri/Documents/risc/test_op_reg.vhd
-- Project Name:  risc
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: op_reg
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY test_op_reg IS
END test_op_reg;
 
ARCHITECTURE behavior OF test_op_reg IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT op_reg
    PORT(
         ent : IN  std_logic_vector(15 downto 0);
         rst : IN  std_logic;
         clk : IN  std_logic;
         srt : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal tent : std_logic_vector(15 downto 0) := (others => '0');
   signal trst : std_logic := '0';
   signal tclk : std_logic := '0';

 	--Outputs
   signal tsrt : std_logic_vector(15 downto 0);

   -- Clock period definitions
--   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: op_reg PORT MAP (
         tent,trst,tclk ,tsrt
        );

   -- Clock process definitions
--   clk_process :process
--   begin
--		clk <= '0';
--		wait for clk_period/2;
--		clk <= '1';
--		wait for clk_period/2;
--   end process;
 

   -- Stimulus process
trst<='1' , '0' after 20 ns ; 
process 
begin 
tclk <='0' , '1' after 20 ns  ; 
wait for 40 ns ; 
End process ;  
tent <= x"0001",x"0010" after 50 ns ; 

END;
