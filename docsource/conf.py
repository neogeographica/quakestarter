#!/usr/bin/env python3
# -*- coding: utf-8 -*-
#
# Quakestarter documentation build configuration file.
#
# This file is execfile()d with the current directory set to its
# containing dir.
#
# Note that not all possible configuration values are present in this
# autogenerated file.
#
# All configuration values have a default; values that are commented out
# serve to show the default.

# If extensions (or modules to document with autodoc) are in another directory,
# add these directories to sys.path here. If the directory is relative to the
# documentation root, use os.path.abspath to make it absolute, like shown here.
#
# import os
# import sys
# sys.path.insert(0, os.path.abspath('.'))


# -- General configuration ------------------------------------------------

# If your documentation needs a minimal Sphinx version, state it here.
#
needs_sphinx = '4.5.0'

# Add any Sphinx extension module names here, as strings. They can be
# extensions coming with Sphinx (named 'sphinx.ext.*') or your custom
# ones.
extensions = [
    'sphinx.ext.autosectionlabel',
]

autosectionlabel_prefix_document = True
autosectionlabel_maxdepth = 2

# Add any paths that contain templates here, relative to this directory.
templates_path = ['_templates']

# The suffix(es) of source filenames.
# You can specify multiple suffix as a list of string:
#
# source_suffix = ['.rst', '.md']
source_suffix = '.rst'

# The master toctree document.
master_doc = 'quakestarter_readme'

# General information about the project.
project = 'Quakestarter'
copyright = '2022, Joel Baxter'
author = 'Joel Baxter'

# The version info for the project you're documenting, acts as replacement for
# |version| and |release|, also used in various other places throughout the
# built documents.
#
# The full version, including any pre-release tag.
release = '2.6.0-dev'
# And without that tag.
version = release.split('-')[0]

# The language for content autogenerated by Sphinx. Refer to documentation
# for a list of supported languages.
#
# This is also used if you do content translation via gettext catalogs.
# Usually you set "language" from the command line for these cases.
language = None

# List of patterns, relative to source directory, that match files and
# directories to ignore when looking for source files.
# This patterns also effect to html_static_path and html_extra_path
exclude_patterns = ['_build', 'Thumbs.db', '.DS_Store']

# The default language to syntax-highlight literals in.
highlight_language = 'none'

# The name of the Pygments (syntax highlighting) style to use.
#pygments_style = 'sphinx'

# A string of reStructuredText that will be included at the beginning of
# every source file that is read.
rst_prolog = """
.. |br| raw:: html

  <div style="line-height: 0; padding: 0; margin: 0"></div>
"""


# If true, `todo` and `todoList` produce output, else they produce nothing.
todo_include_todos = False


# -- Options for HTML output ----------------------------------------------

# The theme to use for HTML and HTML Help pages.  See the documentation for
# a list of builtin themes.
#
html_theme = 'alabaster'

# Theme options are theme-specific and customize the look and feel of a theme
# further.  For a list of options available for each theme, see the
# documentation.
#
html_theme_options = {
    'caption_font_size': 'larger',
    'description': 'Quake Singleplayer Starter Pack',
    'extra_nav_links': {
        'Quakestarter website': 'http://quakestarter.com'
    },
    'fixed_sidebar': True,
    'page_width': '1024px',
    'show_related': True,
#    'github_user': 'neogeographica',
#    'github_repo': 'quakestarter',
#    'github_type': 'watch',
    'github_button': False,
    'show_relbars': True,
}

# Add any paths that contain custom static files (such as style sheets) here,
# relative to this directory. They are copied after the builtin static files,
# so a file named "default.css" will overwrite the builtin "default.css".
html_static_path = ['_static']

# Custom sidebar templates, must be a dictionary that maps document names
# to template names.
#
# This is required for the alabaster theme
# refs: http://alabaster.readthedocs.io/en/latest/installation.html#sidebars
html_sidebars = {
    '**': [
        'about.html',
        'navigation.html',
#        'relations.html',  # needs 'show_related': True theme option to display
        'searchbox.html',
    ]
}

# If true, the reST sources are included in the HTML build as _sources/name.
#
html_copy_source = False

# If true, links to the reST sources are added to the pages.
#
html_show_sourcelink = False

# If false, no index is generated.
#
html_use_index = False

# The name of an image file (relative to this directory) to use as a favicon of
# the docs.
#
html_favicon = '_static/favicon.ico'
