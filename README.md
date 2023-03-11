# cmp-feature-flipper

This plugin is a source for [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) to complete feature flipper names and descriptions when using the Ruby [flipper gem](https://github.com/jnunemaker/flipper).

Also, this is an early release built around my specific use case and makes many assumptions that I suggest you read through.

## Setup

### Prerequisites / Assumptions

You must use the [flipper gem](https://github.com/jnunemaker/flipper) with a feature name and description file in `./config/feature-descriptions.yml`.

The flipper gem lets you load flipper description data however you want. I work on apps that do it via a YAML file. The format is:

```yaml
feature_flipper_one_name: feature one description
feature_flipper_two_name: feaure two description
```

This plugin regex parses that YAML file for the completion data.

### Installation

Install **cmp-feature-flipper** using your plugin manager of choice. For example, here it is using [**lazy.nvim**](https://github.com/folke/lazy.nvim):

```lua
{
  "hrsh7th/nvim-cmp",
  dependencies = {
    { "wassimk/cmp-feature-flipper", version = "*" },
  },
}
```

Then add `feature-flipper` source in your **nvim-cmp** configuration:

```lua
require("cmp").setup {
  -- ...
  sources = {
    { name = "feature-flipper" },
    -- other sources ...
  },
  -- ...
}
```

## Usage

Completion is triggered when you type any of the trigger strings followed by `("`. For example typing `Features.enabled?("` would trigger the completion menu.

You can also trigger by ending the trigger string with a `'` or `:` instead of the `"`.

### Trigger Strings

- `Features.enabled?`
- `Features.feature_enabled?`
- `featureEnabled`
- `feature_enabled?`
- `with_feature`
- `without_feature`
