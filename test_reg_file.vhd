library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity reg_file_test is
end entity;

architecture arch of reg_file_test is
  signal done   : boolean := false;
  signal passed : boolean := true;
  signal ok     : boolean := true;

  component reg_file is
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
  end component;

  signal clk : std_logic;
  signal rst : std_logic;
  
  signal acc_out : std_logic_vector(15 downto 0);
  signal acc_ce  : std_logic;

  signal pc_out : std_logic_vector(15 downto 0);
  signal pc_ce  : std_logic;
  signal rpc_ce : std_logic;

  signal rx_num : std_logic_vector(5 downto 0);
  signal rx_out : std_logic_vector(15 downto 0);
  signal rx_ce  : std_logic;

  signal din : std_logic_vector(15 downto 0);
begin

  reg_file_0 : reg_file
    port map ( clk => clk,
               rst => rst,

               acc_out => acc_out,
               acc_ce  => acc_ce,

               pc_out => pc_out,
               pc_ce  => pc_ce,
               rpc_ce => rpc_ce,

               rx_num => rx_num,
               rx_out => rx_out,
               rx_ce  => rx_ce,

               din => din );

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
    rst <= '1';
    acc_ce <= '0';
    pc_ce  <= '0';
    rpc_ce <= '0';
    rx_ce  <= '0';
    rx_num <= "000000";
    din    <= X"FFFF";
    wait for 12 ns;
    -- Accumulator CE --------------------------------------------------- 12 ns
    rst <= '0';
    acc_ce <= '1';
    pc_ce  <= '0';
    rpc_ce <= '0';
    rx_ce  <= '0';
    rx_num <= "101010";
    din    <= X"C3C3";
    -- Check all regs ---------------------------------------------------------
    for i in 0 to 63 loop
      wait for 10 ns;
      -- Check reg Ri ------------------------------------------ 22 + 10 x i ns
      rst <= '0';
      acc_ce <= '0';
      pc_ce  <= '0';
      rpc_ce <= '0';
      rx_ce  <= '0';
      rx_num <= conv_std_logic_vector(i, 6);
      din    <= X"FFFF";
    end loop;
    wait for 10 ns;
    -- Program counter CE ---------------------------------------------- 662 ns
    rst <= '0';
    acc_ce <= '0';
    pc_ce  <= '1';
    rpc_ce <= '0';
    rx_ce  <= '0';
    rx_num <= "010101";
    din    <= X"3C3C";
    -- Check all regs ---------------------------------------------------------
    for i in 0 to 63 loop
      wait for 10 ns;
      -- Check reg Ri ----------------------------------------- 672 + 10 x i ns
      rst <= '0';
      acc_ce <= '0';
      pc_ce  <= '0';
      rpc_ce <= '0';
      rx_ce  <= '0';
      rx_num <= conv_std_logic_vector(i, 6);
      din    <= X"FFFF";
    end loop;
    wait for 10 ns;
    -- Return program counter CE -------------------------------------- 1312 ns
    rst <= '0';
    acc_ce <= '0';
    pc_ce  <= '0';
    rpc_ce <= '1';
    rx_ce  <= '0';
    rx_num <= "110011";
    din    <= X"9696";
    -- Check all regs ---------------------------------------------------------
    for i in 0 to 63 loop
      wait for 10 ns;
      -- Check reg Ri----------------------------------------- 1322 + 10 x i ns
      rst <= '0';
      acc_ce <= '0';
      pc_ce  <= '0';
      rpc_ce <= '0';
      rx_ce  <= '0';
      rx_num <= conv_std_logic_vector(i, 6);
      din    <= X"FFFF";
    end loop;
    -- Register CE ------------------------------------------------------------
    for i in 0 to 63 loop
      wait for 10 ns;
      -- Register Rx CE -------------------------------------- 1962 + 10 x i ns
      rst <= '0';
      acc_ce <= '0';
      pc_ce  <= '0';
      rpc_ce <= '0';
      rx_ce  <= '1';
      rx_num <= conv_std_logic_vector((i mod 32)*2 + (i/32), 6);
      din    <= (not conv_std_logic_vector(i, 8)) &
                     conv_std_logic_vector(i, 8);
    end loop;
    -- Check all regs ---------------------------------------------------------
    for i in 0 to 63 loop
      wait for 10 ns;
      -- Check reg Ri ---------------------------------------- 2602 + 10 x i ns
      rst <= '0';
      acc_ce <= '0';
      pc_ce  <= '0';
      rpc_ce <= '0';
      rx_ce  <= '0';
      rx_num <= conv_std_logic_vector(i, 6);
      din    <= X"FFFF";
    end loop;
    wait for 10 ns;
    ------------------------------------------------------------------- 3242 ns
    rst <= 'U';
    acc_ce <= 'U';
    pc_ce  <= 'U';
    rpc_ce <= 'U';
    rx_ce  <= 'U';
    rx_num <= "UUUUUU";
    din    <= "UUUUUUUUUUUUUUUU";
    wait;
  end process;

  -----------------------------------------------------------------------------
  -- Output verification
  -----------------------------------------------------------------------------

  process
  begin
    wait for 9 ns;
    -- Reset (before clk) ------------------------------------------------ 9 ns
    ok   <= (acc_out = X"0000") and
            (pc_out  = X"A000") and
            (rx_out  = X"0000");
    wait for 2 ns;
    -- Reset (after clk) ------------------------------------------------ 11 ns
    ok   <= (acc_out = X"0000") and
            (pc_out  = X"A000") and
            (rx_out  = X"0000");
    wait for 8 ns;
    -- Accumulator CE (before clk) -------------------------------------- 19 ns
    ok   <= (acc_out = X"0000") and
            (pc_out  = X"A000") and
            (rx_out  = X"0000");
    wait for 2 ns;
    -- Accumulator CE (after clk) --------------------------------------- 21 ns
    ok   <= (acc_out = X"C3C3") and
            (pc_out  = X"A000") and
            (rx_out  = X"0000");
    -- Check all regs ---------------------------------------------------------
    for i in 0 to 63 loop
      wait for 8 ns;
      -- Check reg Ri (before clk) ----------------------------- 29 + 10 x i ns
      if i = 0 then
        ok   <= (acc_out = X"C3C3") and
                (pc_out  = X"A000") and
                (rx_out  = X"C3C3");
      elsif i = 63 then
        ok   <= (acc_out = X"C3C3") and
                (pc_out  = X"A000") and
                (rx_out  = X"A000");
      else
        ok   <= (acc_out = X"C3C3") and
                (pc_out  = X"A000") and
                (rx_out  = X"0000");
      end if;
      wait for 2 ns;
      -- Check reg Ri (after clk) ------------------------------ 31 + 10 x i ns
      if i = 0 then
        ok   <= (acc_out = X"C3C3") and
                (pc_out  = X"A000") and
                (rx_out  = X"C3C3");
      elsif i = 63 then
        ok   <= (acc_out = X"C3C3") and
                (pc_out  = X"A000") and
                (rx_out  = X"A000");
      else
        ok   <= (acc_out = X"C3C3") and
                (pc_out  = X"A000") and
                (rx_out  = X"0000");
      end if;
    end loop;
    wait for 8 ns;
    -- Program counter CE (before clk) --------------------------------- 669 ns
    ok   <= (acc_out = X"C3C3") and
            (pc_out  = X"A000") and
            (rx_out  = X"0000");
    wait for 2 ns;
    -- Program counter CE (after clk) ---------------------------------- 671 ns
    ok   <= (acc_out = X"C3C3") and
            (pc_out  = X"3C3C") and
            (rx_out  = X"0000");
    -- Check all regs ---------------------------------------------------------
    for i in 0 to 63 loop
      wait for 8 ns;
      -- Check reg Ri (before clk) ---------------------------- 679 + 10 x i ns
      if i = 0 then
        ok   <= (acc_out = X"C3C3") and
                (pc_out  = X"3C3C") and
                (rx_out  = X"C3C3");
      elsif i = 63 then
        ok   <= (acc_out = X"C3C3") and
                (pc_out  = X"3C3C") and
                (rx_out  = X"3C3C");
      else
        ok   <= (acc_out = X"C3C3") and
                (pc_out  = X"3C3C") and
                (rx_out  = X"0000");
      end if;
      wait for 2 ns;
      -- Check reg Ri (after clk) ----------------------------- 681 + 10 x i ns
      if i = 0 then
        ok   <= (acc_out = X"C3C3") and
                (pc_out  = X"3C3C") and
                (rx_out  = X"C3C3");
      elsif i = 63 then
        ok   <= (acc_out = X"C3C3") and
                (pc_out  = X"3C3C") and
                (rx_out  = X"3C3C");
      else
        ok   <= (acc_out = X"C3C3") and
                (pc_out  = X"3C3C") and
                (rx_out  = X"0000");
      end if;
    end loop;
    wait for 8 ns;
    -- Return program counter CE (before clk) ------------------------- 1319 ns
    ok   <= (acc_out = X"C3C3") and
            (pc_out  = X"3C3C") and
            (rx_out  = X"0000");
    wait for 2 ns;
    -- Return program counter CE (after clk) -------------------------- 1321 ns
    ok   <= (acc_out = X"C3C3") and
            (pc_out  = X"3C3C") and
            (rx_out  = X"0000");
    -- Check all regs ---------------------------------------------------------
    for i in 0 to 63 loop
      wait for 8 ns;
      -- Check reg Ri (before clk) --------------------------- 1329 + 10 x i ns
      if i = 0 then
        ok   <= (acc_out = X"C3C3") and
                (pc_out  = X"3C3C") and
                (rx_out  = X"C3C3");
      elsif i = 62 then
        ok   <= (acc_out = X"C3C3") and
                (pc_out  = X"3C3C") and
                (rx_out  = X"9696");
      elsif i = 63 then
        ok   <= (acc_out = X"C3C3") and
                (pc_out  = X"3C3C") and
                (rx_out  = X"3C3C");
      else
        ok   <= (acc_out = X"C3C3") and
                (pc_out  = X"3C3C") and
                (rx_out  = X"0000");
      end if;
      wait for 2 ns;
      -- Check reg Ri (after clk) ---------------------------- 1331 + 10 x i ns
      if i = 0 then
        ok   <= (acc_out = X"C3C3") and
                (pc_out  = X"3C3C") and
                (rx_out  = X"C3C3");
      elsif i = 62 then
        ok   <= (acc_out = X"C3C3") and
                (pc_out  = X"3C3C") and
                (rx_out  = X"9696");
      elsif i = 63 then
        ok   <= (acc_out = X"C3C3") and
                (pc_out  = X"3C3C") and
                (rx_out  = X"3C3C");
      else
        ok   <= (acc_out = X"C3C3") and
                (pc_out  = X"3C3C") and
                (rx_out  = X"0000");
      end if;
    end loop;
    -- Register CE ------------------------------------------------------------
    for i in 0 to 63 loop
      wait for 8 ns;
      -- Register Rx CE (before clk) ------------------------- 1969 + 10 x i ns
      if i = 0 then
        ok   <= (acc_out = X"C3C3") and
                (pc_out  = X"3C3C") and
                (rx_out  = X"C3C3");
      elsif i = 31 then
        ok   <= (acc_out = X"FF00") and
                (pc_out  = X"3C3C") and
                (rx_out  = X"9696");
      elsif i = 63 then
        ok   <= (acc_out = X"FF00") and
                (pc_out  = X"3C3C") and
                (rx_out  = X"3C3C");
      else
        ok   <= (acc_out = X"FF00") and
                (pc_out  = X"3C3C") and
                (rx_out  = X"0000");
      end if;
      wait for 2 ns;
      -- Register Rx CE (after clk) -------------------------- 1971 + 10 x i ns
      if i = 63 then
        ok   <= (acc_out = X"FF00") and
                (pc_out  = X"C03F") and
                (rx_out  = X"C03F");
      else
        ok   <= (acc_out = X"FF00") and
                (pc_out  = X"3C3C") and
                (rx_out  = (not conv_std_logic_vector(i, 8)) &
                                conv_std_logic_vector(i, 8));
      end if;
    end loop;
    -- Check all regs ---------------------------------------------------------
    for i in 0 to 63 loop
      wait for 8 ns;
      -- Check reg Ri (before clk) --------------------------- 2609 + 10 x i ns
      ok   <= (acc_out = X"FF00") and
              (pc_out  = X"C03F") and
              (rx_out  = (not conv_std_logic_vector((i mod 2)*32 + i/2, 8)) &
                              conv_std_logic_vector((i mod 2)*32 + i/2, 8));
      wait for 2 ns;
      -- Check reg Ri (after clk) ---------------------------- 2611 + 10 x i ns
      ok   <= (acc_out = X"FF00") and
              (pc_out  = X"C03F") and
              (rx_out  = (not conv_std_logic_vector((i mod 2)*32 + i/2, 8)) &
                              conv_std_logic_vector((i mod 2)*32 + i/2, 8));
    end loop;
    wait for 1 ns;
    ------------------------------------------------------------------- 3242 ns
    ok   <= true;
    done <= true;
    wait;
  end process;

  passed <= passed and ok;

end architecture;