Package.describe(
    {
        name: 'laboratory:ddp-monitor',
        version: '0.1.0',
        summary: 'DDP Live Monitoring',
        git: 'https://github.com/Laboratory/ddp-monitor.git',
        documentation: 'README.md'
    }
);

Package.onUse(function (api) {
    api.versionsFrom('1.2');
    api.use(['coffeescript'], ['client', 'server']);
    api.addFiles('lib/server/server.coffee', 'server');
    api.addFiles('lib/server/autopublish.coffee', 'server');
    api.addFiles('lib/client/autosubscribe.coffee', 'client');
    api.export('DDPMonitor');
});

Package.onTest(function (api) {
        api.use('tinytest');
        api.use('laboratory:ddp-monitor');
        //api.addFiles('ddp-monitor-tests.js');
    }
);
