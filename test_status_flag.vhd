library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity status_reg_test is
end entity;

architecture arch of status_reg_test is
  signal done   : boolean := false;
  signal passed : boolean := true;
  signal ok     : boolean := true;

  component status_reg is
   port ( clk : in  std_logic;
          ce  : in  std_logic;
          rst : in  std_logic;

          i : in  std_logic_vector(3 downto 0);
          o : out std_logic_vector(3 downto 0) );
  end component;

  signal clk : std_logic;
  signal ce  : std_logic;
  signal rst : std_logic;
  
  signal i : std_logic_vector(3 downto 0);
  signal o : std_logic_vector(3 downto 0);
begin

  status_reg_0 : status_reg
    port map ( clk => clk,
               ce  => ce,
               rst => rst,

               i => i,
               o => o );

  -----------------------------------------------------------------------------
  -- Clock signal
  -----------------------------------------------------------------------------

  process
  begin
    if not done then
      clk <= '1';
      wait for 5 ns;
      clk <= '0';
      wait for 5 ns;
    else
      clk <= 'U';
      wait;
    end if;
  end process;

  -----------------------------------------------------------------------------
  -- Input stimuli
  -----------------------------------------------------------------------------

  process
  begin
    -- Reset ------------------------------------------------------------- 0 ns
    ce  <= '0';
    rst <= '1';
    i   <= "1111";
    wait for 12 ns;
    -- Clock enabled ---------------------------------------------------- 12 ns
    ce  <= '1';
    rst <= '0';
    i   <= "1010";
    wait for 10 ns;
    -- Clock disabled --------------------------------------------------- 22 ns
    ce  <= '0';
    rst <= '0';
    i   <= "1111";
    wait for 10 ns;
    --------------------------------------------------------------------- 32 ns
    ce  <= 'U';
    rst <= 'U';
    i   <= "UUUU";
    wait;
  end process;

  -----------------------------------------------------------------------------
  -- Output verification
  -----------------------------------------------------------------------------

  process
  begin
    wait for 9 ns;
    -- Reset (before clk) ------------------------------------------------ 9 ns
    ok <= (o = "0000");
    wait for 2 ns;
    -- Reset (after clk) ------------------------------------------------ 11 ns
    ok <= (o = "0000");
    wait for 8 ns;
    -- Clock enabled (before clk) --------------------------------------- 19 ns
    ok <= (o = "0000");
    wait for 2 ns;
    -- Clock enabled (after clk) ---------------------------------------- 21 ns
    ok <= (o = "1010");
    wait for 8 ns;
    -- Clock disabled (before clk) -------------------------------------- 29 ns
    ok <= (o = "1010");
    wait for 2 ns;
    -- Clock disabled (after clk) --------------------------------------- 31 ns
    ok <= (o = "1010");
    wait for 1 ns;
    --------------------------------------------------------------------- 32 ns
    ok   <= true;
    done <= true;
    wait;
  end process;

  passed <= passed and ok;
  
end architecture;