module.exports = {
    title: 'IPengine',
    description: 'the best ip source',
    themeConfig: {
        nav: [
            { text: 'Home', link: '/' },
            {
                text: 'Documentation', ariaLabel: 'Documentation Menu',
                items: [
                    { text: 'Docs', link: '/docs/' },
                    { text: 'Pricing', link: '/pricing' },
                    { text: 'Login', link: '/login' },
                    { text: 'Blog', link: '/blog/' }
                ]
            },
        ],
        sidebar: [
            {
                title: 'Getting started',
                collapsable: true,
                children: [
                    '/docs/',
                    '/docs/ip'
                ]
            },
            {
                title: 'Features',
                collapsable: true,
                children: [
                    '/docs/languages',
                    '/docs/content-type',
                    '/docs/module'
                ]
            },
            {
                title: 'Usage',
                collapsable: true,
                children: [
                    '/docs/status',
                    '/docs/response',
                    '/docs/security',
                    '/docs/changelog',
                    '/docs/comparison'
                ]
            }
        ]
    }
}