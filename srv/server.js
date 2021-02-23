const proxy = require('@sap/cds-odata-v2-adapter-proxy')
const cds = require('@sap/cds')
const color = require('color');

global.__base = __dirname + "/"
console.log(global.__base)
console.log(`CDS Custom Boostrap from /srv/server.js`);

process.on('uncaughtException', function (err) {
    console.error(err.name + ': ' + err.message, err.stack.replace(/.*\n/, '\n')) // eslint-disable-line
})

process.on('SIGTERM', function (err) {
    server.close();
    console.error(err.name + ': ' + err.message, err.stack.replace(/.*\n/, '\n')) // eslint-disable-line
})

process.once('SIGUSR2', function () {
    process.kill(process.pid, 'SIGUSR2');
});

process.on('SIGINT', function () {
    // this is only called on ctrl+c, not restart
    process.kill(process.pid, 'SIGINT');
});

cds.on('bootstrap', app => app.use(proxy({
    services: {
        "/TimesheetService/": "TimesheetService"
    }
})))

// module.exports = cds.server

//Delegate to default server.js
module.exports = async (o) => {
    o.port = process.env.PORT || 4012
    //API route (Disabled by default)
    o.baseDir = global.__base
    o.routes = []

    const express = require('express')
    let app = express()
    app.express = express
    app.baseDir = o.baseDir
    o.app = app

    const path = require('path')
    const fileExists = require('fs').existsSync
    let expressFile = path.join(app.baseDir, 'server/express.js')
    if (fileExists(expressFile)) {
        await require(expressFile)(app)
    }

    // //CDS REST Handler
    // let restURL = "/rest/"
    // cds.serve('TimesheetService')
    //     .from(global.__base + "/gen/csn.json")
    //     .to("rest")
    //     .at(restURL + 'TimesheetService')
    //     .with(require("./handlers/timesheet-service"))
    //     .in(app)
    //     .catch((err) => {
    //         app.logger.error(err);
    //     })

    o.app.httpServer = await cds.server(o)

    //Load Custom Routes
    const glob = require('glob')
    let routesDir = path.join(global.__base, 'routes/**/*.js')
    let files = glob.sync(routesDir)
    this.routerFiles = files;
    if (files.length !== 0) {
        for (let file of files) {
            await require(file)(app, o.app.httpServer)
        }
    }


    return o.app.httpServer
}