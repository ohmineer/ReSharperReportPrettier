<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl">
  <xsl:key name="ISSUETYPES" match="/Report/Issues/Project/Issue" use="@TypeId" />
  <xsl:output method="html" indent="yes" />
  <xsl:template match="/" name="TopLevelReport">
    <xsl:text disable-output-escaping='yes'>&lt;!doctype html&gt;&#13;</xsl:text>
    <html lang="en">
      <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" integrity="sha512-1ycn6IcaQQ40/MKBW2W4Rhis/DbILU74C1vSrLJxCq57o941Ym01SwNsOMqvEBFlcgUa6xLiPY/NS5R+E6ztJQ==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-table/1.19.1/bootstrap-table.min.css" integrity="sha512-Ulm5pOx2O8n6XDa0CY2S+GfOmV2R2SrvCpVmhjsxi4VmvcqB5JM5POLuePq496f9CkeAtvPpJlcjLRcTPk79iw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <link href="https://unpkg.com/bootstrap-table@1.19.1/dist/extensions/sticky-header/bootstrap-table-sticky-header.css" rel="stylesheet" />

        <link href="https://fonts.googleapis.com/css2?family=Roboto" rel="stylesheet" />

        <style>
          * {
            box-sizing: border-box;
            margin: 0;
          }

          body {
            width: 100%;
            height: 100%;
            font-family: 'Roboto', sans-serif;
          }

          .main {
            display: flex;
            flex-direction: column;
            padding: 10px;
          }

          .header {
            align-self: flex-start;
          }

          .table-responsive {
            align-self: center;
            width: 100%;
          }</style>

        <title>Resharper CLT Code Inspection Report</title>
      </head>
      <body>
        <div class="main bg-dark bg-gradient text-white">
          <div class="header">
            <h1>Resharper CLT Code Inspection Report</h1>
          </div>

          <div class="card-group d-flex flex-row justify-content-evenly mb-3" style="font-size: 1rem; height: 8rem;">

            <div class="card text-white bg-primary d-flex flex-row text-center align-items-center d-none" style="max-width: 20%;">
              <div class="col">
                <i class="fas fa-info-circle fa-4x"></i>
              </div>
              <div class="col">
                <div class="card-body">
                  <h5 class="card-subtitle">Hints</h5>
                  <h2 id="card-hint" class="card-title"></h2>
                </div>
              </div>
            </div>

            <div class="card text-white bg-success d-flex flex-row text-center align-items-center d-none" style="max-width: 20%;">
              <div class="col">
                <i class="fas fa-lightbulb fa-4x"></i>
              </div>
              <div class="col">
                <div class="card-body">
                  <h5 class="card-subtitle">Suggestions</h5>
                  <h2 id="card-suggestion" class="card-title"></h2>
                </div>
              </div>
            </div>

            <div class="card bg-warning d-flex flex-row text-center align-items-center d-none" style="max-width: 20%;">
              <div class="col">
                <i class="fas fa-exclamation-triangle fa-4x"></i>
              </div>
              <div class="col">
                <div class="card-body">
                  <h5 class="card-subtitle">Warnings</h5>
                  <h2 id="card-warning" class="card-title"></h2>
                </div>
              </div>
            </div>

            <div class="card text-white bg-danger d-flex flex-row text-center align-items-center d-none" style="max-width: 20%;">
              <div class="col">
                <i class="fas fa-bug fa-4x"></i>
              </div>
              <div class="col">
                <div class="card-body">
                  <h5 class="card-subtitle">Errors</h5>
                  <h2 id="card-error" class="card-title"></h2>
                </div>
              </div>
            </div>

          </div>

          <div class="table-responsive">
            <table id="table" class="table table-sm table-bordered table-hover align-middle table-dark" data-toggle="table" data-search="true" data-search-align="left" data-buttons-align="left" data-show-columns="true" data-pagination="true" data-pagination-v-align="both" data-page-list="[10, 25, 50, 100, All]" data-sticky-header="true">
              <thead>
                <tr>
                  <th scope="col" data-field="severity" data-sortable="true" data-switchable="false" data-width="5" data-width-unit="%">Severity</th>
                  <th scope="col" data-field="project" data-sortable="true" data-width="10" data-width-unit="%">Project</th>
                  <th scope="col" data-field="file" data-sortable="true" data-switchable="false" data-width="20" data-width-unit="%">File</th>
                  <th scope="col" data-field="lineNumber" data-switchable="false" data-width="5" data-width-unit="%">Line Number</th>
                  <th scope="col" data-field="message" data-width="30" data-width-unit="%">Message</th>
                  <th scope="col" data-field="category" data-sortable="true">Category</th>
                  <th scope="col" data-field="moreInfo">More Info</th>
                </tr>
              </thead>
              <tbody>
                <xsl:for-each select="/Report/Issues/Project">
                  <xsl:variable name="ProjectName" select="@Name" />
                  <xsl:for-each select="/Report/Issues/Project[@Name = $ProjectName]/Issue">
                    <xsl:variable name="TypeId" select="@TypeId" />
                    <xsl:variable name="IssueType" select="/Report/IssueTypes/IssueType[@Id = $TypeId]" />
                    <tr>
                      <td>
                        <xsl:choose>
                          <xsl:when test="$IssueType/@Severity='WARNING'">
                            <span class="badge bg-warning text-dark">
                              <xsl:value-of select="$IssueType/@Severity" />
                            </span>
                          </xsl:when>
                          <xsl:when test="$IssueType/@Severity='SUGGESTION'">
                            <span class="badge bg-success">
                              <xsl:value-of select="$IssueType/@Severity" />
                            </span>
                          </xsl:when>
                          <xsl:when test="$IssueType/@Severity='HINT'">
                            <span class="badge bg-info text-dark">
                              <xsl:value-of select="$IssueType/@Severity" />
                            </span>
                          </xsl:when>
                          <xsl:when test="$IssueType/@Severity='ERROR'">
                            <span class="badge bg-danger text-dark">
                              <xsl:value-of select="$IssueType/@Severity" />
                            </span>
                          </xsl:when>
                          <xsl:otherwise>
                            <span class="badge bg-secondary">
                              <xsl:value-of select="$IssueType/@Severity" />
                            </span>
                          </xsl:otherwise>
                        </xsl:choose>
                      </td>
                      <td>
                        <xsl:value-of select="$ProjectName" />
                      </td>
                      <td>
                        <xsl:value-of select="@File" />
                      </td>
                      <td>
                        <xsl:value-of select="@Line" />
                      </td>
                      <td>
                        <xsl:value-of select="@Message" />
                      </td>
                      <td>
                        <xsl:value-of select="$IssueType/@Category" />
                      </td>
                      <td>
                        <a href="{$IssueType/@WikiUrl}">
                          <xsl:value-of select="$IssueType/@Description" />
                        </a>
                      </td>
                    </tr>
                  </xsl:for-each>
                </xsl:for-each>
              </tbody>
            </table>
          </div>
        </div>

        <script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/js/all.min.js" integrity="sha512-Tn2m0TIpgVyTzzvmxLNuqbSJH3JP8jm+Cy3hvHrW7ndTDcJ1w5mBiksqDBb8GpE2ksktFvDB/ykZ0mDpsZj20w==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-table/1.19.1/bootstrap-table.min.js" integrity="sha512-SoNdA/8QMSSlEcJAXKdAALavPMfGJnoh/96Tosg3qxQhdktSAttyHT7ePJghxJNvLCeyJYtXcdrTgLvHHsbRcQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
        <script src="https://unpkg.com/bootstrap-table@1.19.1/dist/extensions/sticky-header/bootstrap-table-sticky-header.min.js"></script>
        <script>
          const cardHint = document.getElementById('card-hint');
          const cardWarning = document.getElementById('card-warning');
          const cardSuggestion = document.getElementById('card-suggestion');
          const cardError = document.getElementById('card-error');

          const suggestionCount = document.querySelectorAll('.badge.bg-success').length;
          const hintCount = document.querySelectorAll('.badge.bg-info').length;
          const warningCount = document.querySelectorAll('.badge.bg-warning').length;
          const errorCount = document.querySelectorAll('.badge.bg-danger').length;

          if (suggestionCount > 0)
          {
            cardSuggestion.innerText = suggestionCount;
            cardSuggestion.closest('.d-none').classList.remove('d-none');
          }

          if (hintCount > 0)
          {
            cardHint.innerText = hintCount;
            cardHint.closest('.d-none').classList.remove('d-none');
          }

          if (warningCount > 0)
          {
            cardWarning.innerText = warningCount;
            cardWarning.closest('.d-none').classList.remove('d-none');
          }

          if (errorCount > 0)
          {
            cardError.innerText = errorCount;
            cardError.closest('.d-none').classList.remove('d-none');
          }
</script>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>