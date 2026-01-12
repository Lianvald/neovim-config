return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        "c_sharp",
        "razor",
      })
    end,
  },
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      -- make sure registries is a table
      opts.registries = {
        "github:mason-org/mason-registry",
        "github:Crashdummyy/mason-registry",
      }
      -- optional: keep any existing ensure_installed stuff from LazyVim
      opts.ensure_installed = opts.ensure_installed or {}
      -- IMPORTANT: do NOT put "roslyn" or "rzls" here
    end,
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = function(_, opts)
      opts.formatters_by_ft = opts.formatters_by_ft or {}
      opts.format_on_save = opts.format_on_save or {}
      opts.formatters_by_ft.cs = { "csharpier" }
      opts.formatters_by_ft.csproj = { "csharpier" }
      -- opts.format_on_save = {
      --  lsp_fallback = false,
      --  timeout_ms = 2000,
      --}
    end,
  },
  {
    "seblyng/roslyn.nvim",
    ft = { "cs", "razor" },
    lazy = false,
    config = function()
      require("roslyn").setup({
        opts = {
          filewatching = "roslyn",
          broad_search = false,
          lock_target = true,
          choose_target = function(targets)
            -- Prefer .slnx, then .sln
            for _, t in ipairs(targets) do
              if t:match("%.slnx$") then
                return t
              end
            end
            for _, t in ipairs(targets) do
              if t:match("%.sln$") then
                return t
              end
            end
            return targets[1]
          end,
        },
      })

      vim.lsp.config("roslyn", {
        settings = {
          ["csharp|inlay_hints"] = {
            csharp_enable_inlay_hints_for_implicit_object_creation = true,
            csharp_enable_inlay_hints_for_implicit_variable_types = true,
            csharp_enable_inlay_hints_for_lambda_parameter_types = true,
            csharp_enable_inlay_hints_for_types = true,
            dotnet_enable_inlay_hints_for_indexer_parameters = true,
            dotnet_enable_inlay_hints_for_literal_parameters = true,
            dotnet_enable_inlay_hints_for_object_creation_parameters = true,
            dotnet_enable_inlay_hints_for_other_parameters = true,
            dotnet_enable_inlay_hints_for_parameters = true,
            dotnet_suppress_inlay_hints_for_parameters_that_differ_only_by_suffix = true,
            dotnet_suppress_inlay_hints_for_parameters_that_match_argument_name = true,
            dotnet_suppress_inlay_hints_for_parameters_that_match_method_intent = true,
          },
          ["csharp|code_lens"] = {
            dotnet_enable_references_code_lens = true,
            dotnet_enable_tests_code_lens = true,
          },
          ["csharp|background_analysis"] = {
            dotnet_analyzer_diagnostics_scope = "openFiles",
            dotnet_compiler_diagnostics_scope = "openFiles",
          },
          ["csharp|completion"] = {
            dotnet_show_completion_items_from_unimported_namespaces = true,
            dotnet_provide_regex_completions = true,
            dotnet_show_name_completion_suggestions = true,
          },
          ["csharp|symbol_search"] = {
            dotnet_search_reference_assemblies = true,
          },
        },
      })
      vim.lsp.enable("roslyn")
    end,
    init = function()
      vim.filetype.add({
        extension = {
          razor = "razor",
          cshtml = "razor",
        },
      })
    end,
  },
}
