{ st, ... }:

st.override {
    conf = builtins.readFile ./st-config.h;
}
