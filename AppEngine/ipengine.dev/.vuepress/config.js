module.exports = {
    title: 'IPengine',
    description: 'the best ip source',
    themeConfig: {
        nav: [
            { text: 'Home', link: '/' },
            { text: 'Docs', link: '/docs/' },
            { text: 'Pricing', link: '/pricing' },
            { text: 'Blog', link: '/blog/' },
            { text: 'Login', link: '/login' }
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