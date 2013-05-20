try:
    from setuptools import setup
except ImportError:
    from distutils.core import setup

config = {
    'description': 'My First Python Project',
    'author': 'leetom',
    'url': 'URL to get it at.',
    'download_url': 'Where to download it.',
    'author_email': 'leetom@qq.com',
    'version': '0.1',
    'install_requires': ['nose'],
    'packages': ['hello'],
    'scripts': [],
    'name': 'Hello Project'
}

setup(**config)