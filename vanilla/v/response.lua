-- perf
local setmetatable = setmetatable


local Response = {}
Response.__index = Response

function Response:new()
    ngx.header['Content_type'] = 'text/html; charset=UTF-8'
    ngx.header['Power_By'] = 'Vanilla-' .. ngx.app_version
    local instance = {
        status = 200,
        headers = {},
        append_body = '',
        body = '',
        prepend_body = ''
    }
    setmetatable(instance, Response)
    return instance
end

function Response:appendBody(append_body)
    if append_body ~= nil then self.append_body = append_body end
end

function Response:clearBody()
    self.body = nil
end

function Response:clearHeaders()
    for k,_ in pairs(ngx.header) do
        ngx.header[k] = nil
    end
end

function Response:getBody()
    return self.body
end

function Response:getHeader()
    return self.headers
end

function Response:prependBody(prepend_body)
    if prepend_body ~= nil then self.prepend_body = prepend_body end
end

function Response:response()
    local body = {[1]=self.append_body, [2]=self.body, [3]=self.prepend_body}
    ngx.print(table.concat( body, ""))
    return true
end

function Response:setBody(body)
    if body ~= nil then self.body = body end
end

function Response:setStatus(status)
    if status ~= nil then self.status = status end
end

function Response:setHeaders(headers)
    if headers ~=nil then
        for header,value in pairs(headers) do
            ngx.header[header] = value
        end
    end
end

function Response:setHeader(key, value)
	ngx.header[key] = value
end

return Response
