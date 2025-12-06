library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.music_pkg.ALL;

entity music_player_top is
    Port (
        MAX10_CLK1_50 : in  STD_LOGIC; 
        KEY           : in  STD_LOGIC_VECTOR(1 downto 0); 
        GPIO_0        : out STD_LOGIC; 
        HEX0          : out STD_LOGIC_VECTOR(7 downto 0);
        HEX1          : out STD_LOGIC_VECTOR(7 downto 0)
    );
end music_player_top;

architecture Structural of music_player_top is

    signal w_freqs      : freq_array;   
    signal w_enables    : std_logic_vector(3 downto 0);
    signal w_waves      : std_logic_vector(3 downto 0);   

    component tone_generator
        Port ( 
            clk         : in STD_LOGIC; 
            reset       : in STD_LOGIC; 
            enable_tone : in STD_LOGIC; 
            divisor     : in INTEGER; 
            wave_out    : out STD_LOGIC 
        );
    end component;
    
    component instruction_decoder
        Port ( 
            clk         : in STD_LOGIC; 
            reset       : in STD_LOGIC; 
            rom_data    : in STD_LOGIC_VECTOR(15 downto 0); 
            rom_addr    : out INTEGER range 0 to 31;
            tone_freq   : out INTEGER;
            tone_enable : out STD_LOGIC
        );
    end component;
    
    component music_rom
        Port ( 
            addr : in INTEGER range 0 to 31; 
            data : out STD_LOGIC_VECTOR(15 downto 0) 
        );
    end component;

    component audio_mixer
        Port (
            clk      : in STD_LOGIC;
            channels : in STD_LOGIC_VECTOR(3 downto 0); 
            audio_out: out STD_LOGIC
        );
    end component;

    component seven_seg_driver
        Port (
            clk          : in STD_LOGIC;
            current_addr : in INTEGER;
            active_ch    : in STD_LOGIC_VECTOR(3 downto 0);
            hex0_out     : out STD_LOGIC_VECTOR(7 downto 0);
            hex1_out     : out STD_LOGIC_VECTOR(7 downto 0)
        );
    end component;

    signal w_reset      : std_logic;
    signal w_addr       : integer range 0 to 31; 
    signal w_rom_data   : std_logic_vector(15 downto 0);
    
    -- Intermediate signals for monophonic to polyphonic mapping
    signal w_mono_freq   : integer;
    signal w_mono_enable : std_logic;
    
begin

    w_reset <= not KEY(0); 

    U_ROM: music_rom port map (
        addr => w_addr,
        data => w_rom_data
    );

    U_CONTROLLER: instruction_decoder port map (
        clk         => MAX10_CLK1_50,
        reset       => w_reset,
        rom_data    => w_rom_data,
        rom_addr    => w_addr,
        tone_freq   => w_mono_freq,   
        tone_enable => w_mono_enable
    );

    -- Mapping Monophonic to Channel 0
    w_freqs(0) <= w_mono_freq;
    w_enables(0) <= w_mono_enable;
    
    -- Zeroing other channels
    w_freqs(1) <= 0; w_enables(1) <= '0';
    w_freqs(2) <= 0; w_enables(2) <= '0';
    w_freqs(3) <= 0; w_enables(3) <= '0';

    GEN_POLYPHONY: for i in 0 to 3 generate
        U_TONE_GEN_X: tone_generator port map (
            clk         => MAX10_CLK1_50,
            reset       => w_reset,
            enable_tone => w_enables(i), 
            divisor     => w_freqs(i),   
            wave_out    => w_waves(i)    
        );
    end generate GEN_POLYPHONY;

    U_MIXER: audio_mixer port map (
        clk       => MAX10_CLK1_50,
        channels  => w_waves,
        audio_out => GPIO_0 
    );

    U_VISUAL: seven_seg_driver port map (
        clk          => MAX10_CLK1_50,
        current_addr => w_addr,
        active_ch    => w_enables,
        hex0_out     => HEX0,
        hex1_out     => HEX1
    );

end Structural;