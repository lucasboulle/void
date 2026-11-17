# CLIs npm globais com versao de node fixa (ver ~/.local/node-clis/regen)
#
# Precisa vir DEPOIS de 04_asdf.fish e ser prependado, para que os wrappers
# tenham precedencia sobre os shims do asdf. Assim `cdk`, `promptfoo`, etc
# rodam sempre no node de ~/.local/node-clis/current, mesmo dentro de repos
# que pinam outra versao de nodejs no .tool-versions. O `node` em si continua
# resolvendo pelo asdf normalmente -- este diretorio nao contem um `node`.
set -l _node_clis "$HOME/.local/node-clis/bin"
if test -d $_node_clis
    if not contains $_node_clis $PATH
        set -gx --prepend PATH $_node_clis
    end
end
