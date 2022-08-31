--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   00:23:04 05/13/2022
-- Design Name:   
-- Module Name:   /home/maddouri/Documents/risc/test_mux2.vhd
-- Project Name:  risc
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: mux2
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
 
ENTITY test_mux1 IS
END test_mux1;
 
ARCHITECTURE behavior OF test_mux1 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT mux1
    PORT(
         In0 : IN  std_logic_vector(15 downto 0);
         In1 : IN  std_logic_vector(15 downto 0);
         Sel : IN  std_logic;
         Z : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal tIn0 : std_logic_vector(15 downto 0) := (others => '0');
   signal tIn1 : std_logic_vector(15 downto 0) := (others => '0');
   signal tSel : std_logic :='0';

 	--Outputs
   signal tZ : std_logic_vector(15 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
--   constant <clock>_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: mux1 PORT MAP (
          tIn0,
          tIn1,
          tSel,
          tZ
        );

--   -- Clock process definitions
--   <clock>_process :process
--   begin
--		<clock> <= '0';
--		wait for <clock>_period/2;
--		<clock> <= '1';
--		wait for <clock>_period/2;
--   end process;
 

   -- Stimulus process
  

    tIn0<=x"0001" ; 
	 tIn1<=x"0011"; 
	 tSel<='0',  '1' after 30 ns ;

END;
