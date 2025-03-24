// This code is based on Dr.Reinenker's code

const app_name = 'www.dirediredocks.xyz';

export function buildPath(route: string): string {  
    if (process.env.NODE_ENV === 'production') {
        return 'http://' + app_name + '/' + route;
    } else {        
        return 'http://localhost:5000/' + route;
    }
}
export default { buildPath }; 

