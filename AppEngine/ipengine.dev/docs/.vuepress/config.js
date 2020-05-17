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
                    '',
                    'ip'
                ]
            },
            {
                title: 'Features',
                collapsable: true,
                children: [
                    'languages',
                    'content-type',
                    'module'
                ]
            },
            {
                title: 'Usage',
                collapsable: true,
                children: [
                    'status',
                    'response',
                    'security',
                    'changelog',
                    'comparison'
                ]
            }
        ]
    }
}