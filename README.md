# Unigen: *Universe Cluster Generator*

This project is for educational purposes!

### Use

**To create 10 equally sized universes in parallel fashion:**

*warning: unless your machine is super powerful, anything above 50 (equally sized) is not recommended*

```shell
mix unigen.start 10
```

**To create 10 incrementally sized universes (1..10) in parallel fashion:**

*warning: unless your machine is super powerful, anything above 75 (incrementally) is not recommended*

```shell
mix unigen.start 10 true
```

**Once run, the output will look something like (when run incrementally):**

```shell 
64 - anionic

8 - anionic

27 - anionic

216 - anionic

125 - ionic

343 - anionic

512 - anionic

729 - anionic

1000 - anionic

1331 - ionic
```

The number is the size of the universe. The word is the charge of the universe!

### Installation As a Dependency

Not available in Hex yet, but can you use git to install via deps:

```elixir
def deps do
  [{:unigen, git: "https://gitlab.com/selfup/unigen.git"}]
end
```
