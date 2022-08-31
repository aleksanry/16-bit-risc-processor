--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   01:32:40 05/13/2022
-- Design Name:   
-- Module Name:   /home/maddouri/Documents/risc/test_one.vhd
-- Project Name:  risc
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: one
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
 
ENTITY test_one IS
END test_one;
 
ARCHITECTURE behavior OF test_one IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT one
    PORT(
         entr : IN  std_logic_vector(15 downto 0);
         sort : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal tentr : std_logic_vector(15 downto 0) := (others => '0');

 	--Outputs
   signal tsort : std_logic_vector(15 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 

 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: one PORT MAP (
          tentr ,
          tsort 
        ); 

 
 

   -- Stimulus process 
	
	tentr<=x"0000" , x"1000" after 20 ns ;  
	
	
  

END;
