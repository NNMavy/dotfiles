if type -q ansible-playbook
  abbr ap ansible-playbook
  abbr apb 'ansible-playbook --ask-become'
end

if type -q bat
  abbr cat bat
end

if type -q doggo
  abbr dig doggo
end

if type -q git
  abbr gfp 'git fetch -p && git pull'
  abbr gitp 'git push'
  abbr gitpf 'git push -f'
end

if type -q terraform
    abbr tf terraform
end