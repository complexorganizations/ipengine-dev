module.exports = {
    title: 'IPengine',
    description: 'the best ip source',
    themeConfig: {
        nav: [
            { text: 'Home', link: '/' },
            { text: 'Docs', link: '/docs/' },
            { text: 'Pricing', link: '/pricing' },
            { text: 'Blog', link: '/blog/' }
        ],
        sidebar: [
            {
                title: 'Getting started',   // required
                path: '/docs/',      // optional, link of the title, which should be an absolute path and must exist
                collapsable: true, // optional, defaults to true
                sidebarDepth: 3,    // optional, defaults to 1
                children: [
                    '/docs/',
                    '/docs/ip'
                ]
            },
            {
                title: 'Features',   // required
                path: '/docs/',      // optional, link of the title, which should be an absolute path and must exist
                collapsable: true, // optional, defaults to true
                sidebarDepth: 3,    // optional, defaults to 1
                children: [
                    '/docs/languages',
                    '/docs/content-type'
                ]
            },
            {
                title: 'Usage',   // required
                path: '/docs/',      // optional, link of the title, which should be an absolute path and must exist
                collapsable: true, // optional, defaults to true
                sidebarDepth: 3,    // optional, defaults to 1
                children: [
                    '/docs/status',
                    '/docs/response',
                    '/docs/security',
                    '/docs/changelog',
                    '/docs/comparison'
                ]
            },
        ]
    }
}