----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    02:38:16 05/13/2022 
-- Design Name: 
-- Module Name:    principale - Behavioral 
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

entity proc is
    Port ( clk: in  STD_LOGIC;
           rst  : in  STD_LOGIC;
           ram_addr : out  STD_LOGIC_VECTOR (15 downto 0);
           ram_din : out  STD_LOGIC_VECTOR (15 downto 0);
           ram_dout : in  STD_LOGIC_VECTOR (15 downto 0);
           ram_we : out  STD_LOGIC);
end proc;

architecture Behavioral of proc is   

signal sigop2,sigop1, sigalu,sigrxout,sigmux1out, sigaccout, sigpcout , sigmux11out, sigone, sigres, sigdin : std_logic_vector (15 downto 0) ; 
signal sigst , sigop,sigstatus,sigcond : std_logic_vector(3 downto 0 ) ;
signal sigimm,sigupdt, sigselop1,sigselramaddr, sigaccce ,sigpcce, sigrpcce,sigrxce,sigstatusce, siginstrce: std_logic ;  
signal sigval : std_logic_vector(5 downto 0 ) ; 
signal sigval2  :std_logic_vector (15 downto 0):="0000000000"& (sigval) ; 
signal sigselrfdin: std_logic_vector(1 downto 0 ) ;     





 
component alu 
port (op : in  std_logic_vector(3 downto 0);
         i1 : in  std_logic_vector(15 downto 0);
         i2 : in  std_logic_vector(15 downto 0);
         o  : out std_logic_vector(15 downto 0);
         st : out std_logic_vector(3 downto 0));
			end component ;  
			
			
component control 
port ( clk : in  std_logic;
         rst : in  std_logic;

         status     : in  std_logic_vector(3 downto 0);
         instr_cond : in  std_logic_vector(3 downto 0);
         instr_op   : in  std_logic_vector(3 downto 0);
         instr_updt : in  std_logic;

         instr_ce  : out std_logic;
         status_ce : out std_logic;
         acc_ce    : out std_logic;
         pc_ce     : out std_logic;
         rpc_ce    : out std_logic;
         rx_ce     : out std_logic;

         ram_we : out std_logic;

         sel_ram_addr : out std_logic;
         sel_op1      : out std_logic;
         sel_rf_din   : out std_logic_vector(1 downto 0) ); 
		end component ; 
		
component instr_reg
  port ( clk : in  std_logic;
         ce  : in  std_logic;
         rst : in  std_logic;

         instr : in  std_logic_vector(15 downto 0);
         cond  : out std_logic_vector(3 downto 0);
         op    : out std_logic_vector(3 downto 0);
         updt  : out std_logic;
         imm   : out std_logic;
         val   : out std_logic_vector(5 downto 0) ); 
			end component ;  
			
			
component mux1
port (In0, In1 : in std_logic_vector (15 downto 0);
        Sel: in std_logic;
                   Z: out std_logic_vector (15 downto 0)); 
						 
			end component ;  


component mux2 
port (In0, In1, In2: in std_logic_vector (15 downto 0);
        Sel: in std_logic_vector(1 downto 0);
                   Z: out std_logic_vector (15 downto 0));
						 
			end component ;   


component one 
port (entr: in std_logic_vector (15 downto 0 ) ;
							sort: out std_logic_vector (15 downto 0 ) ); 	 
end component ;  

 component op_reg 
port ( ent : in std_logic_vector( 15 downto 0 ) ; 
						rst, clk : in std_logic ;
						srt : out std_logic_vector( 15 downto 0 ));  
						
end component ; 


component reg_file 
port  ( clk : in  std_logic;
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
end component ; 

component status_flag 
port
 ( clk : in  std_logic;
         ce  : in  std_logic;
         rst : in  std_logic;
			i : in  std_logic_vector(3 downto 0);
         o : out std_logic_vector(3 downto 0) ); 
			end component ; 


			

begin  
ual : alu port map (sigop,sigop1,sigop2,sigalu,sigst);  
ctl : control port map (clk, rst, sigstatus, sigcond, sigop, sigupdt, siginstrce, sigstatusce, sigaccce, sigpcce, sigrpcce, sigrxce , ram_we, sigselramaddr, sigselop1, sigselrfdin);  
ir : instr_reg port map (clk, siginstrce,rst,ram_dout,sigcond,sigop,sigupdt,sigimm,sigval);            
mx1 : mux1  port map (sigrxout ,sigval2,sigimm,sigmux1out) ;    
mx11 :  mux1 port map (sigaccout,sigpcout,sigselop1,sigmux11out) ; 
mx111 : mux1 port map (sigpcout,sigop2,sigselramaddr,ram_addr) ; 
mx2 : mux2 port map (sigres,ram_dout,sigone,sigselrfdin,sigdin); 
un : one port map (sigpcout,sigone); 
op1 :op_reg port map (sigmux11out,rst, clk ,sigop1);   
op2 :op_reg port map (sigmux1out,rst, clk ,sigop2); 
res :op_reg port map (sigalu,rst, clk ,sigres);  
rf  : reg_file port map (clk,rst,sigaccout,sigaccce,sigpcout,sigpcce,sigrpcce,sigval,sigrxout,sigrxce,sigdin) ;  
stf : status_flag port map (clk,sigstatusce,rst,sigstatus,sigst);   

   


 

   



end Behavioral;

