"""Defines a module extension to create an emscripten cache."""

load(":toolchains.bzl", toolchain_emscripten_cache = "emscripten_cache")

def _emscripten_cache_ext_impl(ctx):
    all_configuration = []
    all_targets = []
    for mod in ctx.modules:
        for configuration in mod.tags.configuration:
            all_configuration += configuration.flags
        for targets in mod.tags.targets:
            all_targets += targets.targets

    toolchain_emscripten_cache(
        name = "emscripten_cache",
        configuration = all_configuration,
        targets = all_targets,
    )

emscripten_cache = module_extension(
    tag_classes = {
        "configuration": tag_class(attrs = {"flags": attr.string_list()}),
        "targets": tag_class(attrs = {"targets": attr.string_list()}),
    },
    implementation = _emscripten_cache_ext_impl,
)
