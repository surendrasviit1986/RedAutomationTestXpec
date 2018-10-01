<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:case="http://www.lexis-nexis.com/glp/case"
    xmlns:ci="http://www.lexis-nexis.com/ci" xmlns:comm="http://www.lexis-nexis.com/glp/comm"
    xmlns:cttr="http://www.lexis-nexis.com/glp/cttr"
    xmlns:dict="http://www.lexis-nexis.com/glp/dict" xmlns:dig="http://www.lexis-nexis.com/glp/dig"
    xmlns:docinfo="http://www.lexis-nexis.com/glp/docinfo"
    xmlns:frm="http://www.lexis-nexis.com/glp/frm" xmlns:glp="http://www.lexis-nexis.com/glp"
    xmlns:in="http://www.lexis-nexis.com/glp/in" xmlns:jrnl="http://www.lexis-nexis.com/glp/jrnl"
    xmlns:leg="http://www.lexis-nexis.com/glp/leg" xmlns:lnci="http://www.lexis-nexis.com/lnci"
    xmlns:lncle="http://www.lexis-nexis.com/lncle" xmlns:lnclx="http://www.lexis-nexis.com/lnclx"
    xmlns:lndel="http://www.lexis-nexis.com/lndel"
    xmlns:lndocmeta="http://www.lexis-nexis.com/lndocmeta"
    xmlns:lngntxt="http://www.lexis-nexis.com/lngntxt"
    xmlns:lnlit="http://www.lexis-nexis.com/lnlit" xmlns:lnv="http://www.lexis-nexis.com/lnv"
    xmlns:lnvni="http://www.lexis-nexis.com/lnvni" xmlns:lnvx="http://www.lexis-nexis.com/lnvx"
    xmlns:lnvxe="http://www.lexis-nexis.com/lnvxe" xmlns:nitf="urn:nitf:iptc.org.20010418.NITF"
    xmlns:xhtml="http://www.w3c.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    xmlns:ext="http://XsltSampleSite.XsltFunctions/1.0" version="1.0"
    xmlns:exsl="http://exslt.org/common" extension-element-prefixes="exsl">

    <!--  Output file information  -->
    <xsl:output method="html" version="5.0" indent="yes" encoding="UTF-8"/>

    <!--  Strip space between elements  -->
    <xsl:strip-space elements="*"/>
    <xsl:preserve-space elements="text"/>
    <xsl:preserve-space elements="ci:content"/>
    <xsl:preserve-space elements="citefragment"/>
    <xsl:preserve-space elements="entry"/>
    <xsl:preserve-space elements="title"/>


    <!-- Template to match all nodes and attributes  -->
    <xsl:template match="node() | @*">
        <xsl:copy>
            <xsl:apply-templates select="node() | @*"/>
        </xsl:copy>
    </xsl:template>

    <xsl:param name="basefilename"/>

    <!-- Variable filename for getting filename -->
    <xsl:variable name="filename">
        <xsl:value-of select="$basefilename"/>
    </xsl:variable>

    <!--  Template to genrate span id   -->
    <xsl:template name="spanid">
        <xsl:attribute name="id">
            <xsl:number level="any"
                count="comm:body//designum/text() | comm:body//title/text() | comm:body//edpnum/text() | comm:body//leg:empleg/text() | comm:body//entry/text() | comm:body//ci:span/text() | comm:body//fnlabel/text() | comm:body//fnr | comm:body//link/text() | comm:body//page | comm:body//emph/text() | comm:body//lilabel/text() | comm:body//remotelink/text() | comm:body//text/text() | comm:body//ci:content/text() | comm:body//citefragment/text() | comm:body//docinfo:currencystatement/text() | comm:body//date/text() | comm:body//defitem/text() | comm:body//contrib/text() | comm:body//sup/text() | comm:body//sub/text() | comm:body//classname/text() | comm:body//form-chars | comm:body//insert-line | comm:body//name.text/text() | comm:body//dispformula/text() | comm:body//frac/text() | comm:body//numer/text() | comm:body//denom/text() | comm:body//num/text() | comm:body//desiglabel/text() | comm:body//p-limited/text()"
                format="1"/>
        </xsl:attribute>
        <xsl:attribute name="xPath">
            <xsl:call-template name="getXpath"/>
        </xsl:attribute>
    </xsl:template>

    <!--  Root element  -->
    <xsl:template match="COMMENTARYDOC">
        <!--<xsl:element name="html">
                    <xsl:element name="head">
                        <xsl:element name="title">
                            <xsl:value-of select="//docinfo:doc-heading"/>
                        </xsl:element>
                    </xsl:element>
                    <xsl:element name="body">-->
        <xsl:element name="div">
            <xsl:attribute name="class">
                <xsl:text>main</xsl:text>
            </xsl:attribute>
            <xsl:attribute name="data-docid">
                <xsl:value-of select="//docinfo:doc-id"/>
            </xsl:attribute>
            <xsl:attribute name="data-filename">
                <xsl:value-of select="$filename"/>
            </xsl:attribute>
            <xsl:if test="@type">
                <xsl:attribute name="data-type">
                    <xsl:value-of select="@type"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:attribute name="data-contentType">
                <xsl:text>Commentary</xsl:text>
            </xsl:attribute>
            <xsl:apply-templates/>
        </xsl:element>
        <!--  </xsl:element>
                </xsl:element>-->
    </xsl:template>

    <!--  Template to transform docinfo  -->
    <xsl:template match="docinfo">
        <xsl:element name="div">
            <xsl:if test="@partitionnum != ''">
                <xsl:attribute name="data-partitionnum">
                    <xsl:value-of select="@partitionnum"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:if test="@docinfo:doc-heading != ''">
                <xsl:attribute name="data-doc.heading">
                    <xsl:value-of select="//docinfo:doc-heading"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:if test="@docinfo:doc-id != ''">
                <xsl:attribute name="data-doc.id">
                    <xsl:value-of select="//docinfo:doc-id"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:attribute name="data-doc.lang">
                <xsl:value-of select="//docinfo:doc-lang/@lang"/>
            </xsl:attribute>
            <xsl:attribute name="data-doc.country">
                <xsl:value-of select="//docinfo:doc-country/@iso-cc"/>
            </xsl:attribute>
            <xsl:attribute name="data-bookseqnum">
                <xsl:value-of select="//docinfo:bookseqnum"/>
            </xsl:attribute>
            <xsl:if test="child::docinfo:dpsi">
                <xsl:attribute name="data-dpsi">
                    <xsl:value-of select="//docinfo:dpsi/@id-string"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:if test="child::docinfo:dpsi">
                <xsl:attribute name="data-dpsi">
                    <xsl:value-of select="//docinfo:dpsi/@id-string"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:if test="child::docinfo:selector">
                <xsl:attribute name="data-selector">
                    <xsl:value-of select="//docinfo:selector"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:if test="child::docinfo:topiccode">
                <xsl:attribute name="data-selector">
                    <xsl:value-of select="//docinfo:topiccode"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:for-each select="./child::node()">
                <xsl:choose>
                    <xsl:when test="name(.) = 'docinfo:hier'">
                        <xsl:element name="div">
                            <xsl:attribute name="id">
                                <xsl:text>datainfo:hier</xsl:text>
                            </xsl:attribute>
                            <xsl:apply-templates/>
                        </xsl:element>
                    </xsl:when>
                    <xsl:otherwise> </xsl:otherwise>
                </xsl:choose>
            </xsl:for-each>
        </xsl:element>
    </xsl:template>


    <!--  Template to transform docinfo:hierlev  -->
    <xsl:template match="docinfo:hierlev">
        <xsl:element name="div">
            <xsl:attribute name="data-tag">
                <xsl:text>hierlev</xsl:text>
            </xsl:attribute>
            <xsl:attribute name="data-role">
                <xsl:value-of select="@role"/>
            </xsl:attribute>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>



    <!--  Template do not genrate tags   -->
    <xsl:template
        match="comm:body | docinfo:authorattribution | leg:levelbody | leg:bodytext | desig | ci:content | classitem-identifier | bodytext | deflist | legfragment | person | fnbody | classname">
        <xsl:apply-templates/>
    </xsl:template>

    <!--  Template to convert refpt tags Tags   -->
    <xsl:template match="refpt">
        <xsl:element name="span">
            <xsl:attribute name="class">
                <xsl:text>hidden</xsl:text>
            </xsl:attribute>
            <xsl:attribute name="data-refpt_id">
                <xsl:value-of select="@id"/>
            </xsl:attribute>
            <xsl:attribute name="daya-type">
                <xsl:value-of select="@type"/>
            </xsl:attribute>
            <xsl:text> </xsl:text>
        </xsl:element>
        <xsl:apply-templates/>
    </xsl:template>

    <!--  Template to convert note tags Tags   -->
    <xsl:template match="glp:note">
        <xsl:if test="child::node()">
            <xsl:element name="div">
                <xsl:attribute name="class">
                    <xsl:text>note</xsl:text>
                </xsl:attribute>
                <xsl:apply-templates/>
            </xsl:element>
        </xsl:if>
    </xsl:template>


    <!--  Template to skip conversion -->
    <xsl:template match="comm:info | ci:case | ci:lawrev | ci:sesslaw"/>



    <!--  Template to transform leg:level -->
    <xsl:template match="leg:level">
        <xsl:if test="child::node()">
            <xsl:if test="@id">
                <xsl:element name="div">
                    <xsl:attribute name="class">
                        <xsl:text>hiddendiv</xsl:text>
                    </xsl:attribute>
                    <xsl:attribute name="data-value">
                        <xsl:value-of select="@id"/>
                    </xsl:attribute>
                    <xsl:text>  </xsl:text>
                </xsl:element>
            </xsl:if>
            <xsl:apply-templates/>
        </xsl:if>
    </xsl:template>

    <!--  Template to transform level -->
    <xsl:template match="level">
        <xsl:if test="child::node()">
            <xsl:if test="@id">
                <xsl:element name="div">
                    <xsl:attribute name="class">
                        <xsl:text>hiddendiv</xsl:text>
                    </xsl:attribute>
                    <xsl:attribute name="data-value">
                        <xsl:value-of select="@id"/>
                    </xsl:attribute>
                    <xsl:text>  </xsl:text>
                </xsl:element>
            </xsl:if>
            <xsl:element name="div">
                <xsl:choose>
                    <xsl:when test="attribute::leveltype = 'para0'">
                        <xsl:attribute name="class">
                            <xsl:text>para</xsl:text>
                        </xsl:attribute>
                    </xsl:when>
                    <xsl:when test="attribute::leveltype = 'subpara0'">
                        <xsl:attribute name="class">
                            <xsl:text>subpara</xsl:text>
                        </xsl:attribute>
                    </xsl:when>
                    <xsl:when test="attribute::leveltype = 'group'">
                        <xsl:attribute name="class">
                            <xsl:text>group</xsl:text>
                        </xsl:attribute>
                    </xsl:when>
                    <xsl:when test="attribute::leveltype = 'comm.chap'">
                        <xsl:attribute name="class">
                            <xsl:text>commchap</xsl:text>
                        </xsl:attribute>
                    </xsl:when>
                    <!--RC-200 added one more leveltype 'chapter'-->
                    <xsl:when test="attribute::leveltype = 'chapter'">
                        <xsl:attribute name="class">
                            <xsl:text>commchap</xsl:text>
                        </xsl:attribute>
                    </xsl:when>
					<!--End-->
                    <!--End-->
                    <!--RC-331 added one more leveltype 'appendix'-->
                    <xsl:when test="attribute::leveltype = 'appendix'">
                        <xsl:attribute name="class">
                            <xsl:text>appendix</xsl:text>
                        </xsl:attribute>
                    </xsl:when>
                    <!--End-->

                </xsl:choose>
                <xsl:apply-templates/>
            </xsl:element>
        </xsl:if>
    </xsl:template>

    <!-- Template to transform leg:heading   -->
    <xsl:template match="leg:heading">
        <xsl:if test="child::node()">
            <xsl:choose>
                <xsl:when test="parent::leg:level-vrnt/@leveltype = 'subsect'">
                    <xsl:apply-templates/>
                </xsl:when>
                <xsl:when test="parent::leg:level-vrnt/@leveltype = 'subrul'">
                    <xsl:apply-templates/>
                </xsl:when>
                <xsl:when test="parent::leg:level-vrnt/@leveltype = 'subreg'">
                    <xsl:apply-templates/>
                </xsl:when>
                <xsl:when test="parent::leg:level-vrnt/@leveltype = 'subclause'">
                    <xsl:apply-templates/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:element name="div">
                        <xsl:attribute name="class">
                            <xsl:text>title</xsl:text>
                        </xsl:attribute>
                        <xsl:if test="@ln.user-displayed = 'false'">
                            <xsl:attribute name="class">
                                <xsl:text>hiddendiv</xsl:text>
                            </xsl:attribute>
                        </xsl:if>
                        <xsl:choose>
                            <xsl:when
                                test="parent::leg:level-vrnt/@leveltype = 'chapter' or parent::leg:level-vrnt/@leveltype = 'chap'">
                                <xsl:element name="h2">
                                    <xsl:attribute name="class">
                                        <xsl:text>chaptertitle</xsl:text>
                                    </xsl:attribute>
                                    <xsl:apply-templates select="*[not(name(.) = 'leg:histnote')]"/>
                                </xsl:element>
                                <xsl:apply-templates select="leg:histnote"/>
                            </xsl:when>
                            <xsl:when test="parent::leg:level-vrnt/@leveltype = 'act'">
                                <xsl:element name="h2">
                                    <xsl:attribute name="class">
                                        <xsl:text>acttitle</xsl:text>
                                    </xsl:attribute>
                                    <xsl:apply-templates select="*[not(name(.) = 'leg:histnote')]"/>
                                </xsl:element>
                                <xsl:apply-templates select="leg:histnote"/>
                            </xsl:when>
                            <xsl:when test="parent::leg:level-vrnt/@leveltype = 'rule'">
                                <xsl:element name="h2">
                                    <xsl:attribute name="class">
                                        <xsl:text>ruletitle</xsl:text>
                                    </xsl:attribute>
                                    <xsl:apply-templates select="*[not(name(.) = 'leg:histnote')]"/>
                                </xsl:element>
                                <xsl:apply-templates select="leg:histnote"/>
                            </xsl:when>
                            <xsl:when test="parent::leg:level-vrnt/@leveltype = 'order'">
                                <xsl:element name="h2">
                                    <xsl:attribute name="class">
                                        <xsl:text>ordertitle</xsl:text>
                                    </xsl:attribute>
                                    <xsl:apply-templates select="*[not(name(.) = 'leg:histnote')]"/>
                                </xsl:element>
                                <xsl:apply-templates select="leg:histnote"/>
                            </xsl:when>
                            <xsl:when test="parent::leg:level-vrnt/@leveltype = 'part'">
                                <xsl:element name="h2">
                                    <xsl:attribute name="class">
                                        <xsl:text>parttitle</xsl:text>
                                    </xsl:attribute>
                                    <xsl:apply-templates select="*[not(name(.) = 'leg:histnote')]"/>
                                </xsl:element>
                                <xsl:apply-templates select="leg:histnote"/>
                            </xsl:when>
                            <xsl:when test="parent::leg:level-vrnt/@leveltype = 'division'">
                                <xsl:element name="h2">
                                    <xsl:attribute name="class">
                                        <xsl:text>divisiontitle</xsl:text>
                                    </xsl:attribute>
                                    <xsl:apply-templates select="*[not(name(.) = 'leg:histnote')]"/>
                                </xsl:element>
                                <xsl:apply-templates select="leg:histnote"/>
                            </xsl:when>
                            <xsl:when test="parent::leg:level-vrnt/@leveltype = 'appendix'">
                                <xsl:element name="h2">
                                    <xsl:attribute name="class">
                                        <xsl:text>appendixtitle</xsl:text>
                                    </xsl:attribute>
                                    <xsl:apply-templates select="*[not(name(.) = 'leg:histnote')]"/>
                                </xsl:element>
                                <xsl:apply-templates select="leg:histnote"/>
                            </xsl:when>
                            <xsl:when test="parent::leg:level-vrnt/@leveltype = 'sect'">
                                <xsl:element name="h3">
                                    <xsl:attribute name="class">
                                        <xsl:text>sectiontitle</xsl:text>
                                    </xsl:attribute>
                                    <xsl:apply-templates select="*[not(name(.) = 'leg:histnote')]"/>
                                </xsl:element>
                                <xsl:apply-templates select="leg:histnote"/>
                            </xsl:when>
                            <xsl:when test="parent::leg:level-vrnt/@leveltype = 'reg'">
                                <xsl:element name="h3">
                                    <xsl:attribute name="class">
                                        <xsl:text>sectiontitle</xsl:text>
                                    </xsl:attribute>
                                    <xsl:apply-templates select="*[not(name(.) = 'leg:histnote')]"/>
                                </xsl:element>
                                <xsl:apply-templates select="leg:histnote"/>
                            </xsl:when>
                            <xsl:when test="parent::leg:level-vrnt/@leveltype = 'rul'">
                                <xsl:element name="h3">
                                    <xsl:attribute name="class">
                                        <xsl:text>sectiontitle</xsl:text>
                                    </xsl:attribute>
                                    <xsl:apply-templates select="*[not(name(.) = 'leg:histnote')]"/>
                                </xsl:element>
                                <xsl:apply-templates select="leg:histnote"/>
                            </xsl:when>
                            <xsl:when test="parent::leg:level-vrnt/@leveltype = 'clause'">
                                <xsl:element name="h3">
                                    <xsl:attribute name="class">
                                        <xsl:text>sectiontitle</xsl:text>
                                    </xsl:attribute>
                                    <xsl:apply-templates select="*[not(name(.) = 'leg:histnote')]"/>
                                </xsl:element>
                                <xsl:apply-templates select="leg:histnote"/>
                            </xsl:when>
                            <xsl:when test="parent::leg:level-vrnt/@leveltype = 'schedules'">
                                <xsl:element name="h2">
                                    <xsl:attribute name="class">
                                        <xsl:text>schedulestitle</xsl:text>
                                    </xsl:attribute>
                                    <xsl:apply-templates select="*[not(name(.) = 'leg:histnote')]"/>
                                </xsl:element>
                                <xsl:apply-templates select="leg:histnote"/>
                            </xsl:when>
                            <xsl:when test="parent::leg:level-vrnt/@leveltype = 'schedule'">
                                <xsl:element name="h3">
                                    <xsl:attribute name="class">
                                        <xsl:text>scheduletitle</xsl:text>
                                    </xsl:attribute>
                                    <xsl:apply-templates select="*[not(name(.) = 'leg:histnote')]"/>
                                </xsl:element>
                                <xsl:apply-templates select="leg:histnote"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:element name="h3">
                                    <xsl:attribute name="class">
                                        <xsl:text>unknowntitle</xsl:text>
                                    </xsl:attribute>
                                    <xsl:apply-templates select="*[not(name(.) = 'leg:histnote')]"/>
                                </xsl:element>
                                <xsl:apply-templates select="leg:histnote"/>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:element>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:if>
    </xsl:template>

    <!-- Template to transform heading   -->
    <xsl:template match="heading">
        <xsl:if test="child::node()">
            <xsl:choose>
                <xsl:when test="parent::docinfo:hierlev">
                    <xsl:apply-templates/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:element name="div">
                        <xsl:attribute name="class">
                            <xsl:text>title</xsl:text>
                        </xsl:attribute>
                        <!-- RC-170 alignment of heading date 15 Nov 2017-->
                        <xsl:if test="@align">
                            <xsl:attribute name="{name(@align)}">
                                <xsl:value-of select="@align"/>
                            </xsl:attribute>
                        </xsl:if>
                        <!--End-->
                        <xsl:if test="@ln.user-displayed = 'false'">
                            <xsl:attribute name="class">
                                <xsl:text>hiddendiv</xsl:text>
                            </xsl:attribute>
                        </xsl:if>
                        <xsl:choose>
                            <!--RC-200 added one more leveltype 'chapter'-->
                            <xsl:when test="parent::level/@leveltype = 'chapter'">
                                <xsl:element name="h1">
                                    <xsl:attribute name="class">commchaptitle</xsl:attribute>
                                    <xsl:apply-templates/>
                                </xsl:element>
                            </xsl:when>
                            <!--End-->
                            <!--RC-331 added one more leveltype 'appendix'-->
                            <xsl:when test="parent::level/@leveltype = 'appendix'">
                                <xsl:element name="h2">
                                    <xsl:attribute name="class">
                                        <xsl:text>appendixtitle</xsl:text>
                                    </xsl:attribute>
                                    <xsl:apply-templates select="*[not(name(.) = 'leg:histnote')]"/>
                                </xsl:element>
                                <xsl:apply-templates select="leg:histnote"/>
                            </xsl:when>
                            <!--End-->

                            <xsl:when test="parent::level/@leveltype = 'comm.chap'">
                                <xsl:element name="h1">
                                    <xsl:attribute name="class">commchaptitle</xsl:attribute>
                                    <xsl:apply-templates/>
                                </xsl:element>
                            </xsl:when>
                            <xsl:when test="parent::level/@leveltype = 'comm.intro'">
                                <xsl:element name="h1">
                                    <xsl:attribute name="class">commintrotitle</xsl:attribute>
                                    <xsl:apply-templates/>
                                </xsl:element>
                            </xsl:when>
                            <xsl:when test="parent::level/@leveltype = 'miscins'">
                                <xsl:element name="h1">
                                    <xsl:attribute name="class">miscinstitle</xsl:attribute>
                                    <xsl:apply-templates/>
                                </xsl:element>
                            </xsl:when>
                            <xsl:when test="parent::level/@leveltype = 'prac.note.grp'">
                                <xsl:element name="h1">
                                    <xsl:attribute name="class">pracnotegrptitle</xsl:attribute>
                                    <xsl:apply-templates/>
                                </xsl:element>
                            </xsl:when>
                            <xsl:when test="parent::level/@leveltype = 'guidecard'">
                                <xsl:element name="h1">
                                    <xsl:attribute name="class">guidecardtitle</xsl:attribute>
                                    <xsl:apply-templates/>
                                </xsl:element>
                            </xsl:when>
                            <xsl:when test="parent::level/@leveltype = 'group'">
                                <xsl:element name="h2">
                                    <xsl:attribute name="class">grouptitle</xsl:attribute>
                                    <xsl:apply-templates/>
                                </xsl:element>
                            </xsl:when>
                            <xsl:when test="parent::level/@leveltype = 'misc.lst.table'">
                                <xsl:element name="h2">
                                    <xsl:attribute name="class">misctabletitle</xsl:attribute>
                                    <xsl:apply-templates/>
                                </xsl:element>
                            </xsl:when>
                            <xsl:when test="parent::level/@leveltype = 'pubnote'">
                                <xsl:element name="h2">
                                    <xsl:attribute name="class">pubnotetitle</xsl:attribute>
                                    <xsl:apply-templates/>
                                </xsl:element>
                            </xsl:when>
                            <xsl:when
                                test="parent::level/@leveltype = 'FORM.GRP' or parent::level/@leveltype = 'formgrp'">
                                <xsl:element name="h2">
                                    <xsl:attribute name="class">formgrptitle</xsl:attribute>
                                    <xsl:apply-templates/>
                                </xsl:element>
                            </xsl:when>
                            <xsl:when test="parent::level/@leveltype = 'form'">
                                <xsl:element name="h3">
                                    <xsl:attribute name="class">formtitle</xsl:attribute>
                                    <xsl:apply-templates/>
                                </xsl:element>
                            </xsl:when>
                            <xsl:when
                                test="parent::level/@leveltype = 'prec.grp' or parent::level/@leveltype = 'precgrp' or parent::level/@leveltype = 'precgrp1' or parent::level/@leveltype = 'precgrp2' or parent::level/@leveltype = 'precgrp3'">
                                <xsl:element name="h2">
                                    <xsl:attribute name="class">precgrptitle</xsl:attribute>
                                    <xsl:apply-templates/>
                                </xsl:element>
                            </xsl:when>
                            <xsl:when test="parent::level/@leveltype = 'prec'">
                                <xsl:element name="h3">
                                    <xsl:attribute name="class">prectitle</xsl:attribute>
                                    <xsl:apply-templates/>
                                </xsl:element>
                            </xsl:when>
                            <xsl:when test="parent::level/@leveltype = 'comm.att'">
                                <xsl:element name="h3">
                                    <xsl:attribute name="class">commatttitle</xsl:attribute>
                                    <xsl:apply-templates/>
                                </xsl:element>
                            </xsl:when>
                            <xsl:when
                                test="parent::level/@leveltype = 'para0' or parent::level/@leveltype = 'subpara0'">
                                <xsl:element name="h3">
                                    <xsl:attribute name="class">paratitle</xsl:attribute>
                                    <xsl:apply-templates/>
                                </xsl:element>
                            </xsl:when>
                            <xsl:when test="parent::leg:prelim">
                                <xsl:element name="h3">
                                    <xsl:attribute name="class">prelimtitle</xsl:attribute>
                                    <xsl:apply-templates/>
                                </xsl:element>
                            </xsl:when>
                            <xsl:when test="parent::pgrp">
                                <xsl:element name="h3">
                                    <xsl:attribute name="class">paragrouptitle</xsl:attribute>
                                    <xsl:apply-templates/>
                                </xsl:element>
                            </xsl:when>
                            <xsl:when test="parent::leg:comntry">
                                <xsl:element name="h3">
                                    <xsl:attribute name="class">comntrytitle</xsl:attribute>
                                    <xsl:apply-templates/>
                                </xsl:element>
                            </xsl:when>
                            <xsl:when test="parent::glp:note">
                                <xsl:element name="h3">
                                    <xsl:attribute name="class">glpnotetitle</xsl:attribute>
                                    <xsl:apply-templates/>
                                </xsl:element>
                            </xsl:when>
                            <xsl:when test="parent::toc-entry">
                                <xsl:element name="h3">
                                    <xsl:attribute name="class">toctitle</xsl:attribute>
                                    <xsl:apply-templates/>
                                </xsl:element>
                            </xsl:when>
                            <xsl:when test="parent::bodytext">
                                <xsl:element name="h4">
                                    <xsl:attribute name="class">bodytexttitle</xsl:attribute>
                                    <xsl:apply-templates/>
                                </xsl:element>
                            </xsl:when>
                        </xsl:choose>
                    </xsl:element>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:if>
    </xsl:template>


    <!-- Template to transform leg:level-vrnt   -->
    <xsl:template match="leg:level-vrnt">
        <xsl:if test="child::node()">
            <xsl:choose>
                <xsl:when test="@leveltype = 'subsect'">
                    <xsl:element name="div">
                        <xsl:attribute name="class">
                            <xsl:value-of select="@leveltype"/>
                        </xsl:attribute>
                        <xsl:apply-templates/>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="@leveltype = 'subrul'">
                    <xsl:element name="div">
                        <xsl:attribute name="class">
                            <xsl:value-of select="@leveltype"/>
                        </xsl:attribute>
                        <xsl:apply-templates/>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="@leveltype = 'subreg'">
                    <xsl:element name="div">
                        <xsl:attribute name="class">
                            <xsl:value-of select="@leveltype"/>
                        </xsl:attribute>
                        <xsl:apply-templates/>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="@leveltype = 'subclause'">
                    <xsl:element name="div">
                        <xsl:attribute name="class">
                            <xsl:value-of select="@leveltype"/>
                        </xsl:attribute>
                        <xsl:apply-templates/>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="child::leg:heading">
                    <xsl:element name="section">
                        <xsl:attribute name="title">
                            <xsl:choose>
                                <xsl:when test="@toc-caption != ''">
                                    <xsl:value-of select="@toc-caption"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="child::leg:heading"/>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:attribute>
                        <xsl:attribute name="class">
                            <xsl:choose>
                                <xsl:when test="@leveltype = 'chapter' or @leveltype = 'chap'">
                                    <xsl:text>chapter</xsl:text>
                                </xsl:when>
                                <xsl:when test="@leveltype = 'act'">
                                    <xsl:text>act</xsl:text>
                                </xsl:when>
                                <xsl:when test="@leveltype = 'order'">
                                    <xsl:text>order</xsl:text>
                                </xsl:when>
                                <xsl:when test="@leveltype = 'part'">
                                    <xsl:text>part</xsl:text>
                                </xsl:when>
                                <xsl:when test="@leveltype = 'division'">
                                    <xsl:text>division</xsl:text>
                                </xsl:when>
                                <xsl:when
                                    test="@leveltype = 'sect' or @leveltype = 'reg' or @leveltype = 'clause' or @leveltype = 'rul'">
                                    <xsl:text>section</xsl:text>
                                </xsl:when>
                                <xsl:when test="@leveltype = 'schedules'">
                                    <xsl:text>schedules</xsl:text>
                                </xsl:when>
                                <xsl:when test="@leveltype = 'schedule'">
                                    <xsl:text>schedule</xsl:text>
                                </xsl:when>
                                <xsl:when test="@leveltype = 'appendix'">
                                    <xsl:text>appendix</xsl:text>
                                </xsl:when>
                                <xsl:when test="@leveltype = 'forms'">
                                    <xsl:text>forms</xsl:text>
                                </xsl:when>
                                <xsl:when test="@leveltype = 'form'">
                                    <xsl:text>form</xsl:text>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:text>unknown</xsl:text>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:attribute>
                        <xsl:apply-templates/>
                    </xsl:element>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:apply-templates/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:if>
    </xsl:template>


    <!--  Template to transform h  -->
    <xsl:template match="h">
        <xsl:if test="child::node()">
            <xsl:element name="h4">
                <xsl:if test="./@align">
                    <xsl:attribute name="class">
                        <xsl:value-of select="concat('align', @align)"/>
                    </xsl:attribute>
                </xsl:if>
                <xsl:apply-templates/>
            </xsl:element>
        </xsl:if>
    </xsl:template>


    <!--  Template to transform edpnum  -->
    <xsl:template match="edpnum">
        <xsl:if test="child::node()">
            <xsl:choose>
                <xsl:when test="./ancestor::docinfo:hierlev"/>
                <xsl:when
                    test="ancestor::heading/@ln.user-displayed = 'false' or ancestor::leg:heading/@ln.user-displayed = 'false'">
                    <xsl:element name="div">
                        <xsl:attribute name="class">
                            <xsl:text>hiddendiv</xsl:text>
                        </xsl:attribute>
                        <xsl:element name="span">
                            <xsl:attribute name="class">
                                <xsl:value-of select="name(.)"/>
                            </xsl:attribute>
                            <xsl:apply-templates/>
                        </xsl:element>
                    </xsl:element>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:element name="span">
                        <xsl:attribute name="class">
                            <xsl:value-of select="name(.)"/>
                        </xsl:attribute>
                        <xsl:apply-templates/>
                    </xsl:element>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:if>
    </xsl:template>

    <!-- Template to transform pgrp   -->
    <xsl:template match="pgrp">
        <xsl:if test="child::node()">
            <xsl:choose>
                <xsl:when test="child::heading">
                    <xsl:element name="section">
                        <xsl:attribute name="title">
                            <xsl:value-of select="child::heading"/>
                        </xsl:attribute>
                        <xsl:attribute name="class">
                            <xsl:text>paragroup</xsl:text>
                        </xsl:attribute>
                        <xsl:apply-templates/>
                    </xsl:element>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:apply-templates/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:if>
    </xsl:template>

    <!-- Template to transform leg:empleg   -->
    <xsl:template match="leg:empleg">
        <xsl:if test="child::node()">
            <xsl:element name="span">
                <xsl:attribute name="class">
                    <xsl:text>empoweringlegislation</xsl:text>
                </xsl:attribute>
                <xsl:apply-templates/>
            </xsl:element>
        </xsl:if>
    </xsl:template>

    <!-- Template To transform designum   -->
    <xsl:template match="designum">
        <xsl:if test="child::node()">
            <xsl:choose>
                <xsl:when test="ancestor::docinfo:hierlev"/>
                <xsl:when
                    test="ancestor::heading/@ln.user-displayed = 'false' or ancestor::leg:heading/@ln.user-displayed = 'false'">
                    <xsl:element name="div">
                        <xsl:attribute name="class">
                            <xsl:text>hiddendiv</xsl:text>
                        </xsl:attribute>
                        <xsl:element name="span">
                            <xsl:attribute name="class">
                                <xsl:value-of select="name(.)"/>
                            </xsl:attribute>
                            <xsl:apply-templates/>
                        </xsl:element>
                    </xsl:element>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:element name="span">
                        <xsl:attribute name="class">
                            <xsl:value-of select="name(.)"/>
                        </xsl:attribute>
                        <xsl:apply-templates/>
                    </xsl:element>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:if>
    </xsl:template>

    <!-- Template to transform desiglabel    -->
    <xsl:template match="desiglabel">
        <xsl:if test="child::node()">
            <xsl:element name="span">
                <xsl:attribute name="class">
                    <xsl:value-of select="name(.)"/>
                </xsl:attribute>
                <xsl:apply-templates/>
            </xsl:element>
        </xsl:if>
    </xsl:template>


    <!-- Template to transform title    -->
    <xsl:template match="title">
        <xsl:if test="child::node()">
            <xsl:choose>
                <xsl:when test="parent::table"/>
                <xsl:when test="./ancestor::docinfo:hierlev">
                    <xsl:element name="div">
                        <xsl:attribute name="data-tag">
                            <xsl:text>heading</xsl:text>
                        </xsl:attribute>
                        <xsl:element name="div">
                            <xsl:attribute name="data-tag">
                                <xsl:text>title</xsl:text>
                            </xsl:attribute>
                            <xsl:attribute name="data-value">
                                <xsl:if test="./preceding-sibling::edpnum">
                                    <xsl:value-of select="./preceding-sibling::edpnum"/>
                                    <xsl:text xml:space="preserve"> </xsl:text>
                                </xsl:if>
                                <xsl:if test="./preceding-sibling::desig/designum">
                                    <xsl:value-of select="./preceding-sibling::desig/designum"/>
                                    <xsl:text xml:space="preserve"> </xsl:text>
                                </xsl:if>
                                <xsl:value-of select="."/>
                            </xsl:attribute>
                        </xsl:element>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="parent::leg:heading/parent::leg:level-vrnt/@leveltype = 'subsect'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">
                            <xsl:text>subsect-title</xsl:text>
                        </xsl:attribute>
                        <xsl:apply-templates/>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="parent::leg:heading/parent::leg:level-vrnt/@leveltype = 'subclause'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">
                            <xsl:text>subclause-title</xsl:text>
                        </xsl:attribute>
                        <xsl:apply-templates/>
                    </xsl:element>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:apply-templates/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:if>
    </xsl:template>

    <!-- Template to transform deflist/defitem  -->
    <xsl:template match="deflist/defitem">
        <xsl:if test="child::node()">
            <xsl:choose>
                <xsl:when test="child::leg:histnote">
                    <xsl:element name="dl">
                        <xsl:choose>
                            <xsl:when test="child::defdesc">
                                <xsl:apply-templates select="*[not(name(.) = 'leg:histnote')]"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:apply-templates select="*[not(name(.) = 'leg:histnote')]"/>
                                <xsl:element name="dd"/>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:element>
                    <xsl:apply-templates select="leg:histnote"/>
                </xsl:when>
                <xsl:when test="child::glp:note">
                    <xsl:element name="dl">
                        <xsl:choose>
                            <xsl:when test="child::defdesc">
                                <xsl:apply-templates select="*[not(name(.) = 'glp:note')]"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:apply-templates select="*[not(name(.) = 'glp:note')]"/>
                                <xsl:element name="dd"/>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:element>
                    <xsl:apply-templates select="glp:note"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:element name="dl">
                        <xsl:choose>
                            <xsl:when test="child::defdesc">
                                <xsl:apply-templates/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:apply-templates/>
                                <xsl:element name="dd"/>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:element>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:if>
    </xsl:template>

    <!-- Template to transform defterm   -->
    <xsl:template match="defterm">
        <xsl:if test="child::node()">
            <xsl:choose>
                <xsl:when test="parent::defitem">
                    <xsl:element name="dt">
                        <xsl:element name="span">
                            <xsl:attribute name="class">
                                <xsl:text>quoted</xsl:text>
                            </xsl:attribute>
                        </xsl:element>
                        <xsl:apply-templates/>
                    </xsl:element>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:element name="span">
                        <xsl:attribute name="class">
                            <xsl:text>quoted</xsl:text>
                        </xsl:attribute>
                        <xsl:apply-templates/>
                    </xsl:element>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:if>
    </xsl:template>


    <!--  Template to transform defdesc -->
    <xsl:template match="defdesc">
        <xsl:if test="child::node()">
            <xsl:element name="dd">
                <xsl:apply-templates/>
            </xsl:element>
        </xsl:if>
    </xsl:template>


    <!-- Template to transform first p when parent is bodytext,leg:bodytext,fnbody li  -->
    <!--  Template to match bodytext/p[1]  -->
    <xsl:template match="fnbody/child::p[1]/child::text[1] | li/child::p[1]/child::text[1]">
        <xsl:choose>
            <xsl:when test="child::node()">
                <xsl:apply-templates/>
            </xsl:when>
        </xsl:choose>
    </xsl:template>


    <!--  Template to transform p  -->
    <xsl:template match="p">
        <xsl:choose>
            <xsl:when test="parent::li">
                <xsl:apply-templates/>
            </xsl:when>
            <xsl:when test="name(child::node()) = 'remotelink'">
                <xsl:element name="p">
                    <xsl:apply-templates/>
                </xsl:element>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!-- Updated by keshav kumar for RC-510 05/07/2018 -->
    <xsl:template match="text[normalize-space(.)='Please click on the link below to download this document.'][ancestor::*[last()][self::COMMENTARYDOC] and //docinfo:doc-country/@iso-cc='NZ' and (contains(//docinfo:metaitem[@name='lbu-sourcename']/@value, ' (book)') or //page)]"/>

    <!-- Tamplate to transform text   -->
    <xsl:template match="text">
        <xsl:if test="child::node()">
            <xsl:choose>
                <!--<xsl:when test="parent::p/parent::li">
                    <xsl:apply-templates/>
                </xsl:when>
                <xsl:when test="parent::p/parent::fnbody">
                    <xsl:apply-templates/>
                </xsl:when>-->
                <xsl:when test="child::deflist">
                    <xsl:apply-templates/>
                </xsl:when>
                <xsl:when test="ancestor::leg:heading">
                    <xsl:apply-templates/>
                </xsl:when>
                <xsl:when
                    test="parent::p/parent::leg:bodytext/parent::leg:levelbody/preceding-sibling::leg:heading/child::desig">
                    <xsl:apply-templates/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:element name="p">
                        <xsl:if test="@align">
                            <xsl:attribute name="class">
                                <xsl:value-of select="concat('align', @align)"/>
                            </xsl:attribute>
                        </xsl:if>
                        <xsl:if test="name(preceding-sibling::node()[1]) = 'pnum'">
                            <xsl:element name="span">
                                <xsl:attribute name="class">
                                    <xsl:text>pnum</xsl:text>
                                </xsl:attribute>
                                <xsl:attribute name="data-count">
                                    <xsl:value-of select="preceding-sibling::pnum/@count"/>
                                </xsl:attribute>
                                <xsl:element name="span">
                                    <xsl:call-template name="spanid"/>
                                    <xsl:value-of select="preceding-sibling::pnum"/>
                                </xsl:element>
                            </xsl:element>
                        </xsl:if>
                        <xsl:apply-templates/>
                    </xsl:element>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:if>
    </xsl:template>


    <!-- Template for multiple string replaces   -->
    <xsl:template name="string-replace">
        <xsl:param name="string"/>
        <xsl:param name="replace"/>
        <xsl:param name="with"/>
        <xsl:choose>
            <xsl:when test="contains($string, $replace)">
                <xsl:value-of select="substring-before($string, $replace)"/>
                <xsl:value-of select="$with"/>
                <xsl:call-template name="string-replace">
                    <xsl:with-param name="string" select="substring-after($string, $replace)"/>
                    <xsl:with-param name="replace" select="$replace"/>
                    <xsl:with-param name="with" select="$with"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$string"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>


    <!-- Template to transform ci:cite  -->
    <xsl:template match="ci:cite">
        <xsl:choose>
            <xsl:when test="descendant::ci:span">
                <xsl:apply-templates/>
            </xsl:when>
            <xsl:when test="descendant::remotelink">
                <xsl:apply-templates/>
            </xsl:when>
            <xsl:when
                test="name(child::node()[1]) = 'ci:content' and //docinfo:doc-country/@iso-cc = 'NZ'">
                <xsl:apply-templates/>
            </xsl:when>
            <xsl:when test="name(child::node()[1]) = 'ci:content'">
                <xsl:apply-templates/>
            </xsl:when>
            <!-- end -->
            <!--Keshav: Change-->
            <xsl:when
                test="name(child::node()[1]) = 'ci:case' and child::node()[1]/ci:caseref[normalize-space(.) = '' and not(*)]">
                <xsl:apply-templates/>
            </xsl:when>
            <!--End-->
            <!--RC-113-->
            <xsl:when test="ci:case/ci:caseref[@status = 'unval']">
                <xsl:apply-templates/>
            </xsl:when>
            <!--End-->
            <!--RC-279-->
            <xsl:when test="ci:case/ci:caseref//*/@*[. = '']">
                <xsl:apply-templates/>
            </xsl:when>
            <!--End-->
            <!--RC-304, RC-320-->
            <xsl:when
                test="@status = 'unval' and (@searchtype = 'LEG-REF' or @searchtype = 'leg-ref')">
                <xsl:apply-templates/>
            </xsl:when>
            <!--End-->
            <xsl:otherwise>
                <xsl:element name="a">
                    <xsl:attribute name="class">
                        <xsl:text>external</xsl:text>
                    </xsl:attribute>
                    <xsl:attribute name="href">
                        <xsl:text>looseleaf://...citeref?ctype=</xsl:text>
                        <xsl:choose>
                            <xsl:when test="descendant::ci:case">
                                <xsl:text>case</xsl:text>
                                <xsl:if test="descendant::ci:party1">
                                    <xsl:text>&amp;party1_name=</xsl:text>
                                    <xsl:variable name="party1">
                                        <xsl:call-template name="string-replace">
                                            <xsl:with-param name="string"
                                                select="normalize-space(descendant::ci:party1/@name)"/>
                                            <xsl:with-param name="replace" select="' '"/>
                                            <xsl:with-param name="with" select="'%20'"/>
                                        </xsl:call-template>
                                    </xsl:variable>
                                    <xsl:value-of select="$party1"/>
                                </xsl:if>
                                <xsl:if test="descendant::ci:procphrase">
                                    <xsl:text>&amp;procphrase_txt=</xsl:text>
                                    <xsl:value-of select="descendant::ci:procphrase/@txt"/>
                                </xsl:if>
                                <xsl:if test="descendant::ci:party2">
                                    <xsl:text>&amp;party2_name=</xsl:text>
                                    <xsl:variable name="party2">
                                        <xsl:call-template name="string-replace">
                                            <xsl:with-param name="string"
                                                select="normalize-space(descendant::ci:party2/@name)"/>
                                            <xsl:with-param name="replace" select="' '"/>
                                            <xsl:with-param name="with" select="'%20'"/>
                                        </xsl:call-template>
                                    </xsl:variable>
                                    <xsl:value-of select="$party2"/>
                                </xsl:if>
                                <xsl:if test="descendant::ci:reporter">
                                    <xsl:text>&amp;reporter_value=</xsl:text>
                                    <xsl:value-of select="descendant::ci:reporter/@value"/>
                                </xsl:if>
                                <xsl:if test="descendant::ci:volume">
                                    <xsl:text>&amp;volume_num=</xsl:text>
                                    <xsl:value-of select="descendant::ci:volume/@num"/>
                                </xsl:if>
                                <xsl:if test="descendant::ci:date">
                                    <xsl:text>&amp;date_year=</xsl:text>
                                    <xsl:value-of select="descendant::ci:date/@year"/>
                                </xsl:if>
                                <xsl:if test="descendant::ci:page">
                                    <xsl:text>&amp;page_num=</xsl:text>
                                    <xsl:value-of select="descendant::ci:page/@num"/>
                                </xsl:if>
                                <xsl:if test="descendant::ci:refnum">
                                    <xsl:text>&amp;refnum_num=</xsl:text>
                                    <xsl:value-of select="descendant::ci:refnum/@num"/>
                                </xsl:if>
                            </xsl:when>
                            <xsl:when test="descendant::ci:lawrev">
                                <xsl:if test="@searchtype = 'BOOK-REF'">
                                    <xsl:text>book</xsl:text>
                                    <xsl:if test="descendant::ci:publicationname">
                                        <xsl:text>&amp;publicationname_normpubcode=</xsl:text>
                                        <xsl:value-of
                                            select="descendant::ci:publicationname/@normpubcode"/>
                                    </xsl:if>
                                    <xsl:if test="descendant::ci:date">
                                        <xsl:text>&amp;date_year=</xsl:text>
                                        <xsl:value-of select="descendant::ci:date/@year"/>
                                    </xsl:if>
                                    <xsl:if test="descendant::ci:page">
                                        <xsl:text>&amp;page_num=</xsl:text>
                                        <xsl:value-of select="descendant::ci:page/@num"/>
                                    </xsl:if>
                                </xsl:if>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:choose>
                                    <xsl:when test="descendant::ci:hierlev/@label = 'amendment'">
                                        <xsl:text>amendment</xsl:text>
                                    </xsl:when>
                                    <xsl:when test="descendant::ci:hierlev/@label = 'act'">
                                        <xsl:text>act</xsl:text>
                                    </xsl:when>
                                    <!--Changes done as per RC-191 test-->
                                    <xsl:when test="descendant::ci:hierlev/@label = 'rule'">
                                        <xsl:text>rule</xsl:text>
                                    </xsl:when>
                                    <xsl:when test="descendant::ci:hierlev/@label = 'instruction'">
                                        <xsl:text>instruction</xsl:text>
                                    </xsl:when>
                                    <xsl:when test="descendant::ci:hierlev/@label = 'reg-no'">
                                        <xsl:text>reg-no</xsl:text>
                                    </xsl:when>
                                    <!--End-->
                                    <!--Changes done as per RC-173 test-->
                                    <xsl:when test="descendant::ci:hierlev/@label = 'num'">
                                        <xsl:text>num</xsl:text>
                                    </xsl:when>
                                    <xsl:when test="descendant::ci:hierlev/@label = 'leg-bill'">
                                        <xsl:text>leg-bill</xsl:text>
                                    </xsl:when>
                                    <!--End-->
                                    <xsl:when test="descendant::ci:hierlev/@label = 'local-rule'">
                                        <xsl:text>local-rule</xsl:text>
                                    </xsl:when>
                                    <xsl:when test="descendant::ci:hierlev/@label = 'section'">
                                        <xsl:text>section</xsl:text>
                                    </xsl:when>
                                    <xsl:when test="descendant::ci:hierlev/@label = 'schedule'">
                                        <xsl:text>schedule</xsl:text>
                                    </xsl:when>
                                    <xsl:when test="descendant::ci:hierlev/@label = 'provision'">
                                        <xsl:text>provision</xsl:text>
                                    </xsl:when>
                                    <xsl:when test="descendant::ci:hierlev/@label = 'part'">
                                        <xsl:text>part</xsl:text>
                                    </xsl:when>
                                    <xsl:when test="descendant::ci:hierlev/@label = 'order'">
                                        <xsl:text>order</xsl:text>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:text>act</xsl:text>
                                    </xsl:otherwise>
                                </xsl:choose>
                                <xsl:if test="descendant::ci:in">
                                    <xsl:text>&amp;jurisinfo=in</xsl:text>
                                </xsl:if>
                                <xsl:if test="descendant::ci:my">
                                    <xsl:text>&amp;jurisinfo=my</xsl:text>
                                </xsl:if>
                                <xsl:if test="descendant::ci:hier">
                                    <xsl:for-each select="descendant::ci:hier/descendant::node()">
                                        <xsl:call-template name="ci:hierlev">
                                            <xsl:with-param name="hierlevNode" select="."/>
                                        </xsl:call-template>
                                    </xsl:for-each>
                                </xsl:if>
                                <xsl:if test="descendant::ci:standardname">
                                    <xsl:text>&amp;standardname_normpubcode=</xsl:text>
                                    <xsl:value-of select="descendant::ci:standardname/@normpubcode"
                                    />
                                </xsl:if>
                            </xsl:otherwise>
                        </xsl:choose>
                        <xsl:text>&amp;book_country=</xsl:text>
                        <xsl:value-of select="//docinfo:doc-country/@iso-cc"/>
                    </xsl:attribute>
                    <xsl:apply-templates select="descendant::ci:content"/>
                </xsl:element>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!-- Template to transfrom citefragment   -->
    <xsl:template match="citefragment">
        <xsl:choose>
            <xsl:when test="@searchtype = 'CASE-NAME-REF'">
                <xsl:apply-templates/>
                <xsl:text xml:space="preserve"> </xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!-- template for hierlev   -->
    <xsl:template name="ci:hierlev">
        <xsl:param name="hierlevNode"/>
        <xsl:text>&amp;hierlev_label</xsl:text>
        <xsl:if test="$hierlevNode/parent::ci:hierlev">
            <xsl:value-of select="concat('_', count($hierlevNode/ancestor::ci:hierlev))"/>
        </xsl:if>
        <xsl:value-of select="concat('=', $hierlevNode/@label)"/>
        <xsl:text>&amp;hierlev_num</xsl:text>
        <xsl:if test="$hierlevNode/parent::ci:hierlev">
            <xsl:value-of select="concat('_', count($hierlevNode/ancestor::ci:hierlev))"/>
        </xsl:if>
        <xsl:value-of select="concat('=', $hierlevNode/@num)"/>
    </xsl:template>


    <!-- Template to transform ci:span   -->
    <xsl:template match="ci:span">
        <xsl:if test="child::node()">
            <xsl:variable name="spanid" select="@spanid"/>
            <xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'"/>
            <xsl:variable name="lowercase" select="'abcdefghijklmnopqrstuvwxyz'"/>
            <xsl:variable name="repalced-string">
                <xsl:call-template name="string-replace">
                    <xsl:with-param name="string">
                        <xsl:call-template name="string-replace">
                            <xsl:with-param name="string">
                                <xsl:call-template name="string-replace">
                                    <xsl:with-param name="string">
                                        <xsl:call-template name="string-replace">
                                            <xsl:with-param name="string">
                                                <xsl:call-template name="string-replace">
                                                  <xsl:with-param name="string">
                                                  <xsl:call-template name="string-replace">
                                                  <xsl:with-param name="string"
                                                  select="normalize-space(.)"/>
                                                  <xsl:with-param name="replace" select="' '"/>
                                                  <xsl:with-param name="with" select="'%20'"/>
                                                  </xsl:call-template>
                                                  </xsl:with-param>
                                                  <xsl:with-param name="replace" select="'&#xA;'"/>
                                                  <xsl:with-param name="with" select="'%20'"/>
                                                </xsl:call-template>
                                            </xsl:with-param>
                                            <xsl:with-param name="replace" select="'['"/>
                                            <xsl:with-param name="with" select="'%5B;'"/>
                                        </xsl:call-template>
                                    </xsl:with-param>
                                    <xsl:with-param name="replace" select="']'"/>
                                    <xsl:with-param name="with" select="'%5D;'"/>
                                </xsl:call-template>
                            </xsl:with-param>
                            <xsl:with-param name="replace" select="'('"/>
                            <xsl:with-param name="with" select="'%28;'"/>
                        </xsl:call-template>
                    </xsl:with-param>
                    <xsl:with-param name="replace" select="')'"/>
                    <xsl:with-param name="with" select="'%29;'"/>
                </xsl:call-template>
            </xsl:variable>
            <!--  <xsl:if test="./parent::node()/@searchtype='BOOK-CITE-REF'">
                <xsl:variable name="ReporterValue" select="translate(./ancestor::ci:cite//ci:lawrevref[@ID=substring-before($spanid,'-')]//ci:lawrevlocator/ci:publicationname/@normpubcode,$lowercase,$uppercase)"/>
                <xsl:choose>
                    <xsl:when test="./ancestor::ci:cite[not(child::ci:lawrev)]">
                        <xsl:apply-templates/>
                    </xsl:when>
                    <xsl:when test="not(./ancestor::ci:cite//ci:lawrevref[@spanref=$spanid])">
                        <xsl:apply-templates/>
                    </xsl:when>
                    <xsl:when test="./ancestor::ci:cite//ci:lawrevref[@spanref=$spanid] and ($ReporterValue='')">
                        <xsl:apply-templates/>
                    </xsl:when>
                    <xsl:when test="@status and @status='unval' and ($ReporterValue!='AATA' and $ReporterValue!='AUSTBARREV' and $ReporterValue!='ACCR' and $ReporterValue!='ACLB' and $ReporterValue!='ACLR' and $ReporterValue!='ACSR' and $ReporterValue!='ACTCA' and $ReporterValue!='ACTR' and $ReporterValue!='ACTSC' and $ReporterValue!='AE' and $ReporterValue!='AUSTJNLOFCORPLAW' and $ReporterValue!='AJFL' and $ReporterValue!='AJLL' and $ReporterValue!='ALN' and $ReporterValue!='APLB' and $ReporterValue!='APLJ' and $ReporterValue!='ARM' and $ReporterValue!='BCL' and $ReporterValue!='BLB' and $ReporterValue!='BPR' and $ReporterValue!='CCD' and $ReporterValue!='CCLJ' and $ReporterValue!='CCN' and $ReporterValue!='CL' and $ReporterValue!='CLN' and $ReporterValue!='CLNQ' and $ReporterValue!='CLNV' and $ReporterValue!='CLPR' and $ReporterValue!='CPNN' and $ReporterValue!='DL' and $ReporterValue!='ELB' and $ReporterValue!='FAMCA' and $ReporterValue!='FAMCAFC' and $ReporterValue!='FAMLR' and $ReporterValue!='FCA' and $ReporterValue!='FCAFC' and $ReporterValue!='FCR' and $ReporterValue!='FMCA' and $ReporterValue!='FMCAFAM' and $ReporterValue!='FSR' and $ReporterValue!='HCA' and $ReporterValue!='HLB' and $ReporterValue!='ILB' and $ReporterValue!='ILJ' and $ReporterValue!='IHC' and $ReporterValue!='INSLB' and $ReporterValue!='INTLB' and $ReporterValue!='IPLB' and $ReporterValue!='IPR' and $ReporterValue!='JCL' and $ReporterValue!='JEQ' and $ReporterValue!='MALR' and $ReporterValue!='MVR' and $ReporterValue!='NSWADT' and $ReporterValue!='NSWCA' and $ReporterValue!='NSWCCA' and $ReporterValue!='NSWDC' and $ReporterValue!='NSWLEC' and $ReporterValue!='NSWLR' and $ReporterValue!='NSWSC' and $ReporterValue!='NTCA' and $ReporterValue!='NTCCA' and $ReporterValue!='NTN' and $ReporterValue!='NTR' and $ReporterValue!='NTSC' and $ReporterValue!='PRIVLB' and $ReporterValue!='QCA' and $ReporterValue!='QCAT' and $ReporterValue!='QCLLR' and $ReporterValue!='QDC' and $ReporterValue!='QDR' and $ReporterValue!='QLCR' and $ReporterValue!='QPELR' and $ReporterValue!='QSC' and $ReporterValue!='REP' and $ReporterValue!='SASC' and $ReporterValue!='SASCFC' and $ReporterValue!='SLB' and $ReporterValue!='TASCCA' and $ReporterValue!='TASFC' and $ReporterValue!='TASSC' and $ReporterValue!='TLJ' and $ReporterValue!='TPLB' and $ReporterValue!='URJ' and $ReporterValue!='VR' and $ReporterValue!='VSC' and $ReporterValue!='VSCA' and $ReporterValue!='WADC' and $ReporterValue!='WASAT' and $ReporterValue!='WASC' and $ReporterValue!='WASCA' and $ReporterValue!='AANDE' and $ReporterValue!='AC' and $ReporterValue!='ALLER' and $ReporterValue!='ALLERCC' and $ReporterValue!='ALLER(EC)' and $ReporterValue!='ALLERREP' and $ReporterValue!='ALLERREPEXT' and $ReporterValue!='BCLC' and $ReporterValue!='BHRC' and $ReporterValue!='BMLR' and $ReporterValue!='CHAPP' and $ReporterValue!='CONLR' and $ReporterValue!='CRAPPREP' and $ReporterValue!='CRAPPREP(S)' and $ReporterValue!='ECHR' and $ReporterValue!='EQ' and $ReporterValue!='EXCH' and $ReporterValue!='EXD' and $ReporterValue!='FAM' and $ReporterValue!='HL' and $ReporterValue!='IP&amp;T' and $ReporterValue!='IRLR' and $ReporterValue!='ITLR' and $ReporterValue!='LGR' and $ReporterValue!='P' and $ReporterValue!='PD' and $ReporterValue!='P&amp;D' and $ReporterValue!='PC' and $ReporterValue!='PLR' and $ReporterValue!='QB' and $ReporterValue!='QBD' and $ReporterValue!='TC' and $ReporterValue!='BCB' and $ReporterValue!='BRMB' and $ReporterValue!='CSLB' and $ReporterValue!='DCR' and $ReporterValue!='IPB' and $ReporterValue!='NZAR' and $ReporterValue!='NZCCLR' and $ReporterValue!='NZCPR' and $ReporterValue!='NZCRIMC' and $ReporterValue!='NZELR' and $ReporterValue!='NZFLJ' and $ReporterValue!='NZFLR' and $ReporterValue!='NZIPJ' and $ReporterValue!='NZLJ' and $ReporterValue!='NZLAWREV' and $ReporterValue!='NZLR' and $ReporterValue!='NZLRLC' and $ReporterValue!='NZPC' and $ReporterValue!='NZRMA' and $ReporterValue!='TRNZ' and $ReporterValue!='VUWLR' and $ReporterValue!='ALLSUBSCRIBEDCASESSOURCES')">
                        <xsl:apply-templates/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:element name="a">
                            <xsl:attribute name="class">
                                <xsl:text>external</xsl:text>
                            </xsl:attribute>
                            <xsl:attribute name="href">
                                <xsl:text>looseleaf://...citeref?ctype=</xsl:text>
                                <xsl:if test="./parent::node()/@searchtype='BOOK-CITE-REF'">
                                    <xsl:text>book&amp;element=citefrag_span&amp;lawrevref_ID=</xsl:text>
                                    <xsl:value-of select="./ancestor::ci:cite/ci:lawrev/ci:lawrevref/@ID"/>
                                    <xsl:text>&amp;lawrevref_spanref=</xsl:text>
                                    <xsl:value-of select="./ancestor::ci:cite/ci:lawrev/ci:lawrevref/@spanref"/>
                                    <xsl:text>&amp;publicationname_normpubcode=</xsl:text>
                                    <xsl:value-of select="./ancestor::ci:cite/ci:lawrev/ci:lawrevref/ci:lawrevlocator/ci:publicationname/@normpubcode"/>
                                    <xsl:text>&amp;date_year=</xsl:text>
                                    <xsl:value-of select="./ancestor::ci:cite/ci:lawrev/ci:lawrevref/ci:lawrevlocator/child::ci:issue/ci:date/@year"/>
                                    <xsl:text>&amp;page_num=</xsl:text>
                                    <xsl:value-of select="./ancestor::ci:cite/ci:lawrev/ci:lawrevref/ci:lawrevlocator/child::ci:page/@num"/>
                                    <xsl:text>&amp;book_country=</xsl:text>
                                    <xsl:value-of select="//docinfo:doc-country/@iso-cc"/>
                                    <xsl:text>&amp;LinkName=</xsl:text>
                                    <xsl:value-of select="$repalced-string"/>
                                </xsl:if>
                            </xsl:attribute>
                            <xsl:apply-templates/>
                        </xsl:element>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:if>-->
            <!--<xsl:if test="./parent::node()/@searchtype='CASE-CITE-REF'">
                <xsl:variable name="ReporterValue" select="translate(./ancestor::ci:cite//ci:caseref[@ID=substring-before($spanid,'-')]/child::ci:reporter/@value,$lowercase,$uppercase)"/>
                <xsl:choose>
                    <xsl:when test="./ancestor::ci:cite[not(child::ci:case)]">
                        <xsl:apply-templates/>
                    </xsl:when>
                    <xsl:when test="not(./ancestor::ci:cite//ci:caseref[@spanref=$spanid])">
                        <xsl:apply-templates/>
                    </xsl:when>
                    <xsl:when test="./ancestor::ci:cite//ci:caseref[@spanref=$spanid] and ($ReporterValue='')">
                        <xsl:apply-templates/>
                    </xsl:when>
                    <xsl:when test="@status and @status='unval' and ($ReporterValue!='AATA' and $ReporterValue!='AUSTBARREV' and $ReporterValue!='ACCR' and $ReporterValue!='ACLB' and $ReporterValue!='ACLR' and $ReporterValue!='ACSR' and $ReporterValue!='ACTCA' and $ReporterValue!='ACTR' and $ReporterValue!='ACTSC' and $ReporterValue!='AE' and $ReporterValue!='AUSTJNLOFCORPLAW' and $ReporterValue!='AJFL' and $ReporterValue!='AJLL' and $ReporterValue!='ALN' and $ReporterValue!='APLB' and $ReporterValue!='APLJ' and $ReporterValue!='ARM' and $ReporterValue!='BCL' and $ReporterValue!='BLB' and $ReporterValue!='BPR' and $ReporterValue!='CCD' and $ReporterValue!='CCLJ' and $ReporterValue!='CCN' and $ReporterValue!='CL' and $ReporterValue!='CLN' and $ReporterValue!='CLNQ' and $ReporterValue!='CLNV' and $ReporterValue!='CLPR' and $ReporterValue!='CPNN' and $ReporterValue!='DL' and $ReporterValue!='ELB' and $ReporterValue!='FAMCA' and $ReporterValue!='FAMCAFC' and $ReporterValue!='FAMLR' and $ReporterValue!='FCA' and $ReporterValue!='FCAFC' and $ReporterValue!='FCR' and $ReporterValue!='FMCA' and $ReporterValue!='FMCAFAM' and $ReporterValue!='FSR' and $ReporterValue!='HCA' and $ReporterValue!='HLB' and $ReporterValue!='ILB' and $ReporterValue!='ILJ' and $ReporterValue!='IHC' and $ReporterValue!='INSLB' and $ReporterValue!='INTLB' and $ReporterValue!='IPLB' and $ReporterValue!='IPR' and $ReporterValue!='JCL' and $ReporterValue!='JEQ' and $ReporterValue!='MALR' and $ReporterValue!='MVR' and $ReporterValue!='NSWADT' and $ReporterValue!='NSWCA' and $ReporterValue!='NSWCCA' and $ReporterValue!='NSWDC' and $ReporterValue!='NSWLEC' and $ReporterValue!='NSWLR' and $ReporterValue!='NSWSC' and $ReporterValue!='NTCA' and $ReporterValue!='NTCCA' and $ReporterValue!='NTN' and $ReporterValue!='NTR' and $ReporterValue!='NTSC' and $ReporterValue!='PRIVLB' and $ReporterValue!='QCA' and $ReporterValue!='QCAT' and $ReporterValue!='QCLLR' and $ReporterValue!='QDC' and $ReporterValue!='QDR' and $ReporterValue!='QLCR' and $ReporterValue!='QPELR' and $ReporterValue!='QSC' and $ReporterValue!='REP' and $ReporterValue!='SASC' and $ReporterValue!='SASCFC' and $ReporterValue!='SLB' and $ReporterValue!='TASCCA' and $ReporterValue!='TASFC' and $ReporterValue!='TASSC' and $ReporterValue!='TLJ' and $ReporterValue!='TPLB' and $ReporterValue!='URJ' and $ReporterValue!='VR' and $ReporterValue!='VSC' and $ReporterValue!='VSCA' and $ReporterValue!='WADC' and $ReporterValue!='WASAT' and $ReporterValue!='WASC' and $ReporterValue!='WASCA' and $ReporterValue!='AANDE' and $ReporterValue!='AC' and $ReporterValue!='ALLER' and $ReporterValue!='ALLERCC' and $ReporterValue!='ALLER(EC)' and $ReporterValue!='ALLERREP' and $ReporterValue!='ALLERREPEXT' and $ReporterValue!='BCLC' and $ReporterValue!='BHRC' and $ReporterValue!='BMLR' and $ReporterValue!='CHAPP' and $ReporterValue!='CONLR' and $ReporterValue!='CRAPPREP' and $ReporterValue!='CRAPPREP(S)' and $ReporterValue!='ECHR' and $ReporterValue!='EQ' and $ReporterValue!='EXCH' and $ReporterValue!='EXD' and $ReporterValue!='FAM' and $ReporterValue!='HL' and $ReporterValue!='IP&amp;T' and $ReporterValue!='IRLR' and $ReporterValue!='ITLR' and $ReporterValue!='LGR' and $ReporterValue!='P' and $ReporterValue!='PD' and $ReporterValue!='P&amp;D' and $ReporterValue!='PC' and $ReporterValue!='PLR' and $ReporterValue!='QB' and $ReporterValue!='QBD' and $ReporterValue!='TC' and $ReporterValue!='BCB' and $ReporterValue!='BRMB' and $ReporterValue!='CSLB' and $ReporterValue!='DCR' and $ReporterValue!='IPB' and $ReporterValue!='NZAR' and $ReporterValue!='NZCCLR' and $ReporterValue!='NZCPR' and $ReporterValue!='NZCRIMC' and $ReporterValue!='NZELR' and $ReporterValue!='NZFLJ' and $ReporterValue!='NZFLR' and $ReporterValue!='NZIPJ' and $ReporterValue!='NZLJ' and $ReporterValue!='NZLAWREV' and $ReporterValue!='NZLR' and $ReporterValue!='NZLRLC' and $ReporterValue!='NZPC' and $ReporterValue!='NZRMA' and $ReporterValue!='TRNZ' and $ReporterValue!='VUWLR' and $ReporterValue!='ALLSUBSCRIBEDCASESSOURCES')">
                        <xsl:apply-templates/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:element name="a">
                            <xsl:attribute name="class">
                                <xsl:text>external</xsl:text>
                            </xsl:attribute>
                            <xsl:attribute name="href">
                                <xsl:text>looseleaf://...citeref?ctype=</xsl:text>
                                <xsl:text>case&amp;element=citefrag_span</xsl:text>
                                <xsl:if test="./ancestor::ci:cite/ci:case/ci:caseinfo/ci:decisiondate/@year">
                                    <xsl:text>&amp;decisiondate_year=</xsl:text>
                                    <xsl:value-of select="normalize-space(./ancestor::ci:cite/ci:case/ci:caseinfo/ci:decisiondate/@year)"/>
                                </xsl:if>
                                <xsl:text>&amp;caseref_ID=</xsl:text>
                                <xsl:value-of select="substring-before(./@spanid,'-')"/>
                                <xsl:text>&amp;caseref_spanref=</xsl:text>
                                <xsl:value-of select="./@spanid"/>
                                <xsl:if test="./ancestor::ci:cite//ci:caseref[@spanref=$spanid]/@anaphref">
                                    <xsl:text>&amp;caseref_anaphref=</xsl:text>
                                    <xsl:value-of select="substring-before(./@spanid,'-')"/>
                                    <xsl:if test="./ancestor::ci:cite//ci:caseref[@anaphref=substring-before($spanid,'-')]/@status">
                                        <xsl:text>&amp;caseref_status=</xsl:text>
                                        <xsl:value-of select="./ancestor::ci:cite//ci:caseref[@anaphref=substring-before($spanid,'-')]/@status"/>
                                    </xsl:if>
                                    <xsl:if test="./ancestor::ci:cite//ci:caseref[@ID=substring-before($spanid,'-')]/ci:reporter/@value">
                                        <xsl:text>&amp;reporter_value=</xsl:text>
                                        <xsl:variable name="reporter_value">
                                            <xsl:call-template name="string-replace">
                                                <xsl:with-param name="string" select="./ancestor::ci:cite//ci:caseref[@ID=substring-before($spanid,'-')]/ci:reporter/@value"/>
                                                <xsl:with-param name="replace" select="' '"/>
                                                <xsl:with-param name="with" select="'%20'"/>
                                            </xsl:call-template>
                                        </xsl:variable>
                                        <xsl:value-of select="$reporter_value"/>
                                    </xsl:if>
                                    <xsl:if test="./ancestor::ci:cite//ci:caseref[@ID=substring-before($spanid,'-')]/ci:edition/ci:date/@year">
                                        <xsl:text>&amp;date_year=</xsl:text>
                                        <xsl:value-of select="./ancestor::ci:cite//ci:caseref[@ID=substring-before($spanid,'-')]/ci:edition/ci:date/@year"/>
                                    </xsl:if>
                                    <xsl:if test="./ancestor::ci:cite//ci:caseref[@ID=substring-before($spanid,'-')]/ci:volume/@num">
                                        <xsl:text>&amp;volume_num=</xsl:text>
                                        <xsl:value-of select="./ancestor::ci:cite//ci:caseref[@ID=substring-before($spanid,'-')]/ci:volume/@num"/>
                                    </xsl:if>
                                    <xsl:if test="./ancestor::ci:cite//ci:caseref[@ID=substring-before($spanid,'-')]/ci:page/@num">
                                        <xsl:text>&amp;page_num=</xsl:text>
                                        <xsl:value-of select="./ancestor::ci:cite//ci:caseref[@ID=substring-before($spanid,'-')]/ci:page/@num"/>
                                    </xsl:if>
									 <xsl:if test="./ancestor::ci:cite//ci:caseref[@ID=substring-before($spanid,'-')]/ci:refnum/@num">
                                        <xsl:text>&amp;refnum_num=</xsl:text>
                                        <xsl:value-of select="./ancestor::ci:cite//ci:caseref[@ID=substring-before($spanid,'-')]/ci:refnum/@num"/>
                                    </xsl:if>
                                    <xsl:if test="./ancestor::ci:cite//ci:caseref[@spanref=$spanid]/ci:pinpoint">
                                        <xsl:text>&amp;pinpoint_num=</xsl:text>
                                        <xsl:value-of select="./ancestor::ci:cite//ci:caseref[@spanref=$spanid]/ci:pinpoint/@num"/>
                                        <xsl:text>&amp;pinpoint_targettype=</xsl:text>
										<xsl:value-of select="./ancestor::ci:cite//ci:caseref[@spanref=$spanid]/ci:pinpoint/@targettype"/>
                                    </xsl:if>
                                </xsl:if>
                                <xsl:if test="./ancestor::ci:cite//ci:caseref[@spanref=$spanid]/ci:reporter/@value">
                                    <xsl:text>&amp;reporter_value=</xsl:text>
                                    <xsl:variable name="reporter_value">
                                        <xsl:call-template name="string-replace">
                                            <xsl:with-param name="string" select="./ancestor::ci:cite//ci:caseref[@ID=substring-before($spanid,'-')]/ci:reporter/@value"/>
                                            <xsl:with-param name="replace" select="' '"/>
                                            <xsl:with-param name="with" select="'%20'"/>
                                        </xsl:call-template>
                                    </xsl:variable>
                                    <xsl:value-of select="$reporter_value"/>
                                </xsl:if>
                                <xsl:if test="./ancestor::ci:cite//ci:caseref[@spanref=$spanid]/ci:refnum/@num">
                                    <xsl:text>&amp;refnum_num=</xsl:text>
                                    <xsl:value-of select="normalize-space(./ancestor::ci:cite//ci:caseref[@spanref=$spanid]/ci:refnum/@num)"/>
                                </xsl:if>
                                <xsl:if test="./ancestor::ci:cite//ci:caseref[@spanref=$spanid]/ci:edition/ci:date/@year">
                                    <xsl:text>&amp;date_year=</xsl:text>
                                    <xsl:value-of select="normalize-space(./ancestor::ci:cite//ci:caseref[@spanref=$spanid]/ci:edition/ci:date/@year)"/>
                                </xsl:if>
                                <xsl:if test="./ancestor::ci:cite//ci:caseref[@spanref=$spanid]/ci:volume/@num">
                                    <xsl:text>&amp;volume_num=</xsl:text>
                                    <xsl:value-of select="normalize-space(./ancestor::ci:cite//ci:caseref[@spanref=$spanid]/ci:volume/@num)"/>
                                </xsl:if>
                                <xsl:if test="./ancestor::ci:cite//ci:caseref[@spanref=$spanid]/ci:page/@num">
                                    <xsl:text>&amp;page_num=</xsl:text>
                                    <xsl:value-of select="normalize-space(./ancestor::ci:cite//ci:caseref[@spanref=$spanid]/ci:page/@num)"/>
                                </xsl:if>
                                <xsl:text>&amp;book_country=</xsl:text>
                                <xsl:value-of select="//docinfo:doc-country/@iso-cc"/>
                                <xsl:choose>
                                    <xsl:when test="./inlineobject"/>
                                    <xsl:otherwise>
                                        <xsl:text>&amp;LinkName=</xsl:text>
                                        <xsl:value-of select="$repalced-string"/>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:attribute>
                            <xsl:apply-templates/>
                        </xsl:element>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:if>-->
            <xsl:choose>
                <xsl:when test="./parent::node()/@searchtype = 'BOOK-CITE-REF'">
                    <xsl:variable name="ReporterValue"
                        select="translate(./ancestor::ci:cite//ci:lawrevref[@ID = substring-before($spanid, '-')]//ci:lawrevlocator/ci:publicationname/@normpubcode, $lowercase, $uppercase)"/>
                    <xsl:choose>
                        <xsl:when test="./ancestor::ci:cite[not(child::ci:lawrev)]">
                            <xsl:apply-templates/>
                        </xsl:when>
                        <xsl:when test="not(./ancestor::ci:cite//ci:lawrevref[@spanref = $spanid])">
                            <xsl:apply-templates/>
                        </xsl:when>
                        <xsl:when
                            test="./ancestor::ci:cite//ci:lawrevref[@spanref = $spanid] and ($ReporterValue = '')">
                            <xsl:apply-templates/>
                        </xsl:when>
                        <xsl:when
                            test="@status and @status='unval' and ($ReporterValue!='AATA' and $ReporterValue!='AUSTBARREV' and $ReporterValue!='ACCR' and $ReporterValue!='ACLB' and $ReporterValue!='ACLR' and $ReporterValue!='ACSR' and $ReporterValue!='ACTCA' and $ReporterValue!='ACTR' and $ReporterValue!='ACTSC' and $ReporterValue!='AE' and $ReporterValue!='AUSTJNLOFCORPLAW' and $ReporterValue!='AJFL' and $ReporterValue!='AJLL' and $ReporterValue!='ALN' and $ReporterValue!='APLB' and $ReporterValue!='APLJ' and $ReporterValue!='ARM' and $ReporterValue!='BCL' and $ReporterValue!='BLB' and $ReporterValue!='BPR' and $ReporterValue!='CCD' and $ReporterValue!='CCLJ' and $ReporterValue!='CCN' and $ReporterValue!='CL' and $ReporterValue!='CLN' and $ReporterValue!='CLNQ' and $ReporterValue!='CLNV' and $ReporterValue!='CLPR' and $ReporterValue!='CPNN' and $ReporterValue!='DL' and $ReporterValue!='ELB' and $ReporterValue!='FAMCA' and $ReporterValue!='FAMCAFC' and $ReporterValue!='FAMLR' and $ReporterValue!='FCA' and $ReporterValue!='FCAFC' and $ReporterValue!='FCR' and $ReporterValue!='FMCA' and $ReporterValue!='FMCAFAM' and $ReporterValue!='FSR' and $ReporterValue!='HCA' and $ReporterValue!='HLB' and $ReporterValue!='ILB' and $ReporterValue!='ILJ' and $ReporterValue!='IHC' and $ReporterValue!='INSLB' and $ReporterValue!='INTLB' and $ReporterValue!='IPLB' and $ReporterValue!='IPR' and $ReporterValue!='JCL' and $ReporterValue!='JEQ' and $ReporterValue!='MALR' and $ReporterValue!='MVR' and $ReporterValue!='NSWADT' and $ReporterValue!='NSWCA' and $ReporterValue!='NSWCCA' and $ReporterValue!='NSWDC' and $ReporterValue!='NSWLEC' and $ReporterValue!='NSWLR' and $ReporterValue!='NSWSC' and $ReporterValue!='NTCA' and $ReporterValue!='NTCCA' and $ReporterValue!='NTN' and $ReporterValue!='NTR' and $ReporterValue!='NTSC' and $ReporterValue!='PRIVLB' and $ReporterValue!='QCA' and $ReporterValue!='QCAT' and $ReporterValue!='QCLLR' and $ReporterValue!='QDC' and $ReporterValue!='QDR' and $ReporterValue!='QLCR' and $ReporterValue!='QPELR' and $ReporterValue!='QSC' and $ReporterValue!='REP' and $ReporterValue!='SASC' and $ReporterValue!='SASCFC' and $ReporterValue!='SLB' and $ReporterValue!='TASCCA' and $ReporterValue!='TASFC' and $ReporterValue!='TASSC' and $ReporterValue!='TLJ' and $ReporterValue!='TPLB' and $ReporterValue!='URJ' and $ReporterValue!='VR' and $ReporterValue!='VSC' and $ReporterValue!='VSCA' and $ReporterValue!='WADC' and $ReporterValue!='WASAT' and $ReporterValue!='WASC' and $ReporterValue!='WASCA' and $ReporterValue!='AANDE' and $ReporterValue!='AC' and $ReporterValue!='ALLER' and $ReporterValue!='ALLERCC' and $ReporterValue!='ALLER(EC)' and $ReporterValue!='ALLERREP' and $ReporterValue!='ALLERREPEXT' and $ReporterValue!='BCLC' and $ReporterValue!='BHRC' and $ReporterValue!='BMLR' and $ReporterValue!='CHAPP' and $ReporterValue!='CONLR' and $ReporterValue!='CRAPPREP' and $ReporterValue!='CRAPPREP(S)' and $ReporterValue!='ECHR' and $ReporterValue!='EQ' and $ReporterValue!='EXCH' and $ReporterValue!='EXD' and $ReporterValue!='FAM' and $ReporterValue!='HL' and $ReporterValue!='IP&amp;T' and $ReporterValue!='IRLR' and $ReporterValue!='ITLR' and $ReporterValue!='LGR' and $ReporterValue!='P' and $ReporterValue!='PD' and $ReporterValue!='P&amp;D' and $ReporterValue!='PC' and $ReporterValue!='PLR' and $ReporterValue!='QB' and $ReporterValue!='QBD' and $ReporterValue!='TC' and $ReporterValue!='BCB' and $ReporterValue!='BRMB' and $ReporterValue!='CSLB' and $ReporterValue!='DCR' and $ReporterValue!='IPB' and $ReporterValue!='NZAR' and $ReporterValue!='NZCCLR' and $ReporterValue!='NZCPR' and $ReporterValue!='NZCRIMC' and $ReporterValue!='NZELR' and $ReporterValue!='NZFLJ' and $ReporterValue!='NZFLR' and $ReporterValue!='NZIPJ' and $ReporterValue!='NZLJ' and $ReporterValue!='NZLAWREV' and $ReporterValue!='NZLR' and $ReporterValue!='NZLRLC' and $ReporterValue!='NZPC' and $ReporterValue!='NZRMA' and $ReporterValue!='TRNZ' and $ReporterValue!='VUWLR' and $ReporterValue!='ALLSUBSCRIBEDCASESSOURCES')">
                            <xsl:apply-templates/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:element name="a">
                                <xsl:attribute name="class">
                                    <xsl:text>external</xsl:text>
                                </xsl:attribute>
                                <xsl:attribute name="href">
                                    <xsl:text>looseleaf://...citeref?ctype=</xsl:text>
                                    <xsl:if test="./parent::node()/@searchtype = 'BOOK-CITE-REF'">
                                        <xsl:text>book&amp;element=citefrag_span&amp;lawrevref_ID=</xsl:text>
                                        <xsl:value-of
                                            select="./ancestor::ci:cite/ci:lawrev/ci:lawrevref/@ID"/>
                                        <xsl:text>&amp;lawrevref_spanref=</xsl:text>
                                        <xsl:value-of
                                            select="./ancestor::ci:cite/ci:lawrev/ci:lawrevref/@spanref"/>
                                        <xsl:text>&amp;publicationname_normpubcode=</xsl:text>
                                        <xsl:value-of
                                            select="./ancestor::ci:cite/ci:lawrev/ci:lawrevref/ci:lawrevlocator/ci:publicationname/@normpubcode"/>
                                        <xsl:text>&amp;date_year=</xsl:text>
                                        <xsl:value-of
                                            select="./ancestor::ci:cite/ci:lawrev/ci:lawrevref/ci:lawrevlocator/child::ci:issue/ci:date/@year"/>
                                        <xsl:text>&amp;page_num=</xsl:text>
                                        <xsl:value-of
                                            select="./ancestor::ci:cite/ci:lawrev/ci:lawrevref/ci:lawrevlocator/child::ci:page/@num"/>
                                        <xsl:text>&amp;book_country=</xsl:text>
                                        <xsl:value-of select="//docinfo:doc-country/@iso-cc"/>
                                        <xsl:text>&amp;LinkName=</xsl:text>
                                        <xsl:value-of select="$repalced-string"/>
                                    </xsl:if>
                                </xsl:attribute>
                                <xsl:apply-templates/>
                            </xsl:element>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:when>
                <xsl:when test="./parent::node()/@searchtype = 'CASE-CITE-REF'">
                    <xsl:variable name="ReporterValue"
                        select="translate(./ancestor::ci:cite//ci:caseref[@ID = substring-before($spanid, '-')]/child::ci:reporter/@value, $lowercase, $uppercase)"/>
                    <xsl:choose>
                        <xsl:when test="./ancestor::ci:cite[not(child::ci:case)]">
                            <xsl:apply-templates/>
                        </xsl:when>
                        <xsl:when test="not(./ancestor::ci:cite//ci:caseref[@spanref = $spanid])">
                            <xsl:apply-templates/>
                        </xsl:when>
                        <xsl:when
                            test="./ancestor::ci:cite//ci:caseref[@spanref = $spanid] and ($ReporterValue = '')">
                            <xsl:apply-templates/>
                        </xsl:when>
                        <xsl:when
                            test="@status and @status='unval' and ($ReporterValue!='AATA' and $ReporterValue!='AUSTBARREV' and $ReporterValue!='ACCR' and $ReporterValue!='ACLB' and $ReporterValue!='ACLR' and $ReporterValue!='ACSR' and $ReporterValue!='ACTCA' and $ReporterValue!='ACTR' and $ReporterValue!='ACTSC' and $ReporterValue!='AE' and $ReporterValue!='AUSTJNLOFCORPLAW' and $ReporterValue!='AJFL' and $ReporterValue!='AJLL' and $ReporterValue!='ALN' and $ReporterValue!='APLB' and $ReporterValue!='APLJ' and $ReporterValue!='ARM' and $ReporterValue!='BCL' and $ReporterValue!='BLB' and $ReporterValue!='BPR' and $ReporterValue!='CCD' and $ReporterValue!='CCLJ' and $ReporterValue!='CCN' and $ReporterValue!='CL' and $ReporterValue!='CLN' and $ReporterValue!='CLNQ' and $ReporterValue!='CLNV' and $ReporterValue!='CLPR' and $ReporterValue!='CPNN' and $ReporterValue!='DL' and $ReporterValue!='ELB' and $ReporterValue!='FAMCA' and $ReporterValue!='FAMCAFC' and $ReporterValue!='FAMLR' and $ReporterValue!='FCA' and $ReporterValue!='FCAFC' and $ReporterValue!='FCR' and $ReporterValue!='FMCA' and $ReporterValue!='FMCAFAM' and $ReporterValue!='FSR' and $ReporterValue!='HCA' and $ReporterValue!='HLB' and $ReporterValue!='ILB' and $ReporterValue!='ILJ' and $ReporterValue!='IHC' and $ReporterValue!='INSLB' and $ReporterValue!='INTLB' and $ReporterValue!='IPLB' and $ReporterValue!='IPR' and $ReporterValue!='JCL' and $ReporterValue!='JEQ' and $ReporterValue!='MALR' and $ReporterValue!='MVR' and $ReporterValue!='NSWADT' and $ReporterValue!='NSWCA' and $ReporterValue!='NSWCCA' and $ReporterValue!='NSWDC' and $ReporterValue!='NSWLEC' and $ReporterValue!='NSWLR' and $ReporterValue!='NSWSC' and $ReporterValue!='NTCA' and $ReporterValue!='NTCCA' and $ReporterValue!='NTN' and $ReporterValue!='NTR' and $ReporterValue!='NTSC' and $ReporterValue!='PRIVLB' and $ReporterValue!='QCA' and $ReporterValue!='QCAT' and $ReporterValue!='QCLLR' and $ReporterValue!='QDC' and $ReporterValue!='QDR' and $ReporterValue!='QLCR' and $ReporterValue!='QPELR' and $ReporterValue!='QSC' and $ReporterValue!='REP' and $ReporterValue!='SASC' and $ReporterValue!='SASCFC' and $ReporterValue!='SLB' and $ReporterValue!='TASCCA' and $ReporterValue!='TASFC' and $ReporterValue!='TASSC' and $ReporterValue!='TLJ' and $ReporterValue!='TPLB' and $ReporterValue!='URJ' and $ReporterValue!='VR' and $ReporterValue!='VSC' and $ReporterValue!='VSCA' and $ReporterValue!='WADC' and $ReporterValue!='WASAT' and $ReporterValue!='WASC' and $ReporterValue!='WASCA' and $ReporterValue!='AANDE' and $ReporterValue!='AC' and $ReporterValue!='ALLER' and $ReporterValue!='ALLERCC' and $ReporterValue!='ALLER(EC)' and $ReporterValue!='ALLERREP' and $ReporterValue!='ALLERREPEXT' and $ReporterValue!='BCLC' and $ReporterValue!='BHRC' and $ReporterValue!='BMLR' and $ReporterValue!='CHAPP' and $ReporterValue!='CONLR' and $ReporterValue!='CRAPPREP' and $ReporterValue!='CRAPPREP(S)' and $ReporterValue!='ECHR' and $ReporterValue!='EQ' and $ReporterValue!='EXCH' and $ReporterValue!='EXD' and $ReporterValue!='FAM' and $ReporterValue!='HL' and $ReporterValue!='IP&amp;T' and $ReporterValue!='IRLR' and $ReporterValue!='ITLR' and $ReporterValue!='LGR' and $ReporterValue!='P' and $ReporterValue!='PD' and $ReporterValue!='P&amp;D' and $ReporterValue!='PC' and $ReporterValue!='PLR' and $ReporterValue!='QB' and $ReporterValue!='QBD' and $ReporterValue!='TC' and $ReporterValue!='BCB' and $ReporterValue!='BRMB' and $ReporterValue!='CSLB' and $ReporterValue!='DCR' and $ReporterValue!='IPB' and $ReporterValue!='NZAR' and $ReporterValue!='NZCCLR' and $ReporterValue!='NZCPR' and $ReporterValue!='NZCRIMC' and $ReporterValue!='NZELR' and $ReporterValue!='NZFLJ' and $ReporterValue!='NZFLR' and $ReporterValue!='NZIPJ' and $ReporterValue!='NZLJ' and $ReporterValue!='NZLAWREV' and $ReporterValue!='NZLR' and $ReporterValue!='NZLRLC' and $ReporterValue!='NZPC' and $ReporterValue!='NZRMA' and $ReporterValue!='TRNZ' and $ReporterValue!='VUWLR' and $ReporterValue!='ALLSUBSCRIBEDCASESSOURCES')">
                            <xsl:apply-templates/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:element name="a">
                                <xsl:attribute name="class">
                                    <xsl:text>external</xsl:text>
                                </xsl:attribute>
                                <xsl:attribute name="href">
                                    <xsl:text>looseleaf://...citeref?ctype=</xsl:text>
                                    <xsl:text>case&amp;element=citefrag_span</xsl:text>
                                    <xsl:if
                                        test="./ancestor::ci:cite/ci:case/ci:caseinfo/ci:decisiondate/@year">
                                        <xsl:text>&amp;decisiondate_year=</xsl:text>
                                        <xsl:value-of
                                            select="normalize-space(./ancestor::ci:cite/ci:case/ci:caseinfo/ci:decisiondate/@year)"
                                        />
                                    </xsl:if>
                                    <xsl:text>&amp;caseref_ID=</xsl:text>
                                    <xsl:value-of select="substring-before(./@spanid, '-')"/>
                                    <xsl:text>&amp;caseref_spanref=</xsl:text>
                                    <xsl:value-of select="./@spanid"/>
                                    <xsl:if
                                        test="./ancestor::ci:cite//ci:caseref[@spanref = $spanid]/@anaphref">
                                        <xsl:text>&amp;caseref_anaphref=</xsl:text>
                                        <xsl:value-of select="substring-before(./@spanid, '-')"/>
                                        <xsl:if
                                            test="./ancestor::ci:cite//ci:caseref[@anaphref = substring-before($spanid, '-')]/@status">
                                            <xsl:text>&amp;caseref_status=</xsl:text>
                                            <xsl:value-of
                                                select="./ancestor::ci:cite//ci:caseref[@anaphref = substring-before($spanid, '-')]/@status"
                                            />
                                        </xsl:if>
                                        <xsl:if
                                            test="./ancestor::ci:cite//ci:caseref[@ID = substring-before($spanid, '-')]/ci:reporter/@value">
                                            <xsl:text>&amp;reporter_value=</xsl:text>
                                            <xsl:variable name="reporter_value">
                                                <xsl:call-template name="string-replace">
                                                  <xsl:with-param name="string"
                                                  select="./ancestor::ci:cite//ci:caseref[@ID = substring-before($spanid, '-')]/ci:reporter/@value"/>
                                                  <xsl:with-param name="replace" select="' '"/>
                                                  <xsl:with-param name="with" select="'%20'"/>
                                                </xsl:call-template>
                                            </xsl:variable>
                                            <xsl:value-of select="$reporter_value"/>
                                        </xsl:if>
                                        <xsl:if
                                            test="./ancestor::ci:cite//ci:caseref[@ID = substring-before($spanid, '-')]/ci:edition/ci:date/@year">
                                            <xsl:text>&amp;date_year=</xsl:text>
                                            <xsl:value-of
                                                select="./ancestor::ci:cite//ci:caseref[@ID = substring-before($spanid, '-')]/ci:edition/ci:date/@year"
                                            />
                                        </xsl:if>
                                        <xsl:if
                                            test="./ancestor::ci:cite//ci:caseref[@ID = substring-before($spanid, '-')]/ci:volume/@num">
                                            <xsl:text>&amp;volume_num=</xsl:text>
                                            <xsl:value-of
                                                select="./ancestor::ci:cite//ci:caseref[@ID = substring-before($spanid, '-')]/ci:volume/@num"
                                            />
                                        </xsl:if>
                                        <xsl:if
                                            test="./ancestor::ci:cite//ci:caseref[@ID = substring-before($spanid, '-')]/ci:page/@num">
                                            <xsl:text>&amp;page_num=</xsl:text>
                                            <xsl:value-of
                                                select="./ancestor::ci:cite//ci:caseref[@ID = substring-before($spanid, '-')]/ci:page/@num"
                                            />
                                        </xsl:if>
                                        <xsl:if
                                            test="./ancestor::ci:cite//ci:caseref[@ID = substring-before($spanid, '-')]/ci:refnum/@num">
                                            <xsl:text>&amp;refnum_num=</xsl:text>
                                            <xsl:value-of
                                                select="./ancestor::ci:cite//ci:caseref[@ID = substring-before($spanid, '-')]/ci:refnum/@num"
                                            />
                                        </xsl:if>
                                        <xsl:if
                                            test="./ancestor::ci:cite//ci:caseref[@spanref = $spanid]/ci:pinpoint">
                                            <xsl:text>&amp;pinpoint_num=</xsl:text>
                                            <xsl:value-of
                                                select="./ancestor::ci:cite//ci:caseref[@spanref = $spanid]/ci:pinpoint/@num"/>
                                            <xsl:text>&amp;pinpoint_targettype=</xsl:text>
                                            <xsl:value-of
                                                select="./ancestor::ci:cite//ci:caseref[@spanref = $spanid]/ci:pinpoint/@targettype"
                                            />
                                        </xsl:if>
                                    </xsl:if>
                                    <xsl:if
                                        test="./ancestor::ci:cite//ci:caseref[@spanref = $spanid]/ci:reporter/@value">
                                        <xsl:text>&amp;reporter_value=</xsl:text>
                                        <xsl:variable name="reporter_value">
                                            <xsl:call-template name="string-replace">
                                                <xsl:with-param name="string"
                                                  select="./ancestor::ci:cite//ci:caseref[@ID = substring-before($spanid, '-')]/ci:reporter/@value"/>
                                                <xsl:with-param name="replace" select="' '"/>
                                                <xsl:with-param name="with" select="'%20'"/>
                                            </xsl:call-template>
                                        </xsl:variable>
                                        <xsl:value-of select="$reporter_value"/>
                                    </xsl:if>
                                    <xsl:if
                                        test="./ancestor::ci:cite//ci:caseref[@spanref = $spanid]/ci:refnum/@num">
                                        <xsl:text>&amp;refnum_num=</xsl:text>
                                        <xsl:value-of
                                            select="normalize-space(./ancestor::ci:cite//ci:caseref[@spanref = $spanid]/ci:refnum/@num)"
                                        />
                                    </xsl:if>
                                    <xsl:if
                                        test="./ancestor::ci:cite//ci:caseref[@spanref = $spanid]/ci:edition/ci:date/@year">
                                        <xsl:text>&amp;date_year=</xsl:text>
                                        <xsl:value-of
                                            select="normalize-space(./ancestor::ci:cite//ci:caseref[@spanref = $spanid]/ci:edition/ci:date/@year)"
                                        />
                                    </xsl:if>
                                    <xsl:if
                                        test="./ancestor::ci:cite//ci:caseref[@spanref = $spanid]/ci:volume/@num">
                                        <xsl:text>&amp;volume_num=</xsl:text>
                                        <xsl:value-of
                                            select="normalize-space(./ancestor::ci:cite//ci:caseref[@spanref = $spanid]/ci:volume/@num)"
                                        />
                                    </xsl:if>
                                    <xsl:if
                                        test="./ancestor::ci:cite//ci:caseref[@spanref = $spanid]/ci:page/@num">
                                        <xsl:text>&amp;page_num=</xsl:text>
                                        <xsl:value-of
                                            select="normalize-space(./ancestor::ci:cite//ci:caseref[@spanref = $spanid]/ci:page/@num)"
                                        />
                                    </xsl:if>
                                    <xsl:text>&amp;book_country=</xsl:text>
                                    <xsl:value-of select="//docinfo:doc-country/@iso-cc"/>
                                    <xsl:choose>
                                        <xsl:when test="./inlineobject"/>
                                        <xsl:otherwise>
                                            <xsl:text>&amp;LinkName=</xsl:text>
                                            <xsl:value-of select="$repalced-string"/>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </xsl:attribute>
                                <xsl:apply-templates/>
                            </xsl:element>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:variable name="ReporterValue"
                        select="translate(./ancestor::ci:cite//ci:caseref[@ID = substring-before($spanid, '-')]/child::ci:reporter/@value, $lowercase, $uppercase)"/>
                    <xsl:choose>
                        <xsl:when test="./ancestor::ci:cite[not(child::ci:case)]">
                            <xsl:apply-templates/>
                        </xsl:when>
                        <xsl:when test="not(./ancestor::ci:cite//ci:caseref[@spanref = $spanid])">
                            <xsl:apply-templates/>
                        </xsl:when>
                        <xsl:when
                            test="./ancestor::ci:cite//ci:caseref[@spanref = $spanid] and ($ReporterValue = '')">
                            <xsl:apply-templates/>
                        </xsl:when>
                        <xsl:when
                            test="@status and @status='unval' and ($ReporterValue!='AATA' and $ReporterValue!='AUSTBARREV' and $ReporterValue!='ACCR' and $ReporterValue!='ACLB' and $ReporterValue!='ACLR' and $ReporterValue!='ACSR' and $ReporterValue!='ACTCA' and $ReporterValue!='ACTR' and $ReporterValue!='ACTSC' and $ReporterValue!='AE' and $ReporterValue!='AUSTJNLOFCORPLAW' and $ReporterValue!='AJFL' and $ReporterValue!='AJLL' and $ReporterValue!='ALN' and $ReporterValue!='APLB' and $ReporterValue!='APLJ' and $ReporterValue!='ARM' and $ReporterValue!='BCL' and $ReporterValue!='BLB' and $ReporterValue!='BPR' and $ReporterValue!='CCD' and $ReporterValue!='CCLJ' and $ReporterValue!='CCN' and $ReporterValue!='CL' and $ReporterValue!='CLN' and $ReporterValue!='CLNQ' and $ReporterValue!='CLNV' and $ReporterValue!='CLPR' and $ReporterValue!='CPNN' and $ReporterValue!='DL' and $ReporterValue!='ELB' and $ReporterValue!='FAMCA' and $ReporterValue!='FAMCAFC' and $ReporterValue!='FAMLR' and $ReporterValue!='FCA' and $ReporterValue!='FCAFC' and $ReporterValue!='FCR' and $ReporterValue!='FMCA' and $ReporterValue!='FMCAFAM' and $ReporterValue!='FSR' and $ReporterValue!='HCA' and $ReporterValue!='HLB' and $ReporterValue!='ILB' and $ReporterValue!='ILJ' and $ReporterValue!='IHC' and $ReporterValue!='INSLB' and $ReporterValue!='INTLB' and $ReporterValue!='IPLB' and $ReporterValue!='IPR' and $ReporterValue!='JCL' and $ReporterValue!='JEQ' and $ReporterValue!='MALR' and $ReporterValue!='MVR' and $ReporterValue!='NSWADT' and $ReporterValue!='NSWCA' and $ReporterValue!='NSWCCA' and $ReporterValue!='NSWDC' and $ReporterValue!='NSWLEC' and $ReporterValue!='NSWLR' and $ReporterValue!='NSWSC' and $ReporterValue!='NTCA' and $ReporterValue!='NTCCA' and $ReporterValue!='NTN' and $ReporterValue!='NTR' and $ReporterValue!='NTSC' and $ReporterValue!='PRIVLB' and $ReporterValue!='QCA' and $ReporterValue!='QCAT' and $ReporterValue!='QCLLR' and $ReporterValue!='QDC' and $ReporterValue!='QDR' and $ReporterValue!='QLCR' and $ReporterValue!='QPELR' and $ReporterValue!='QSC' and $ReporterValue!='REP' and $ReporterValue!='SASC' and $ReporterValue!='SASCFC' and $ReporterValue!='SLB' and $ReporterValue!='TASCCA' and $ReporterValue!='TASFC' and $ReporterValue!='TASSC' and $ReporterValue!='TLJ' and $ReporterValue!='TPLB' and $ReporterValue!='URJ' and $ReporterValue!='VR' and $ReporterValue!='VSC' and $ReporterValue!='VSCA' and $ReporterValue!='WADC' and $ReporterValue!='WASAT' and $ReporterValue!='WASC' and $ReporterValue!='WASCA' and $ReporterValue!='AANDE' and $ReporterValue!='AC' and $ReporterValue!='ALLER' and $ReporterValue!='ALLERCC' and $ReporterValue!='ALLER(EC)' and $ReporterValue!='ALLERREP' and $ReporterValue!='ALLERREPEXT' and $ReporterValue!='BCLC' and $ReporterValue!='BHRC' and $ReporterValue!='BMLR' and $ReporterValue!='CHAPP' and $ReporterValue!='CONLR' and $ReporterValue!='CRAPPREP' and $ReporterValue!='CRAPPREP(S)' and $ReporterValue!='ECHR' and $ReporterValue!='EQ' and $ReporterValue!='EXCH' and $ReporterValue!='EXD' and $ReporterValue!='FAM' and $ReporterValue!='HL' and $ReporterValue!='IP&amp;T' and $ReporterValue!='IRLR' and $ReporterValue!='ITLR' and $ReporterValue!='LGR' and $ReporterValue!='P' and $ReporterValue!='PD' and $ReporterValue!='P&amp;D' and $ReporterValue!='PC' and $ReporterValue!='PLR' and $ReporterValue!='QB' and $ReporterValue!='QBD' and $ReporterValue!='TC' and $ReporterValue!='BCB' and $ReporterValue!='BRMB' and $ReporterValue!='CSLB' and $ReporterValue!='DCR' and $ReporterValue!='IPB' and $ReporterValue!='NZAR' and $ReporterValue!='NZCCLR' and $ReporterValue!='NZCPR' and $ReporterValue!='NZCRIMC' and $ReporterValue!='NZELR' and $ReporterValue!='NZFLJ' and $ReporterValue!='NZFLR' and $ReporterValue!='NZIPJ' and $ReporterValue!='NZLJ' and $ReporterValue!='NZLAWREV' and $ReporterValue!='NZLR' and $ReporterValue!='NZLRLC' and $ReporterValue!='NZPC' and $ReporterValue!='NZRMA' and $ReporterValue!='TRNZ' and $ReporterValue!='VUWLR' and $ReporterValue!='ALLSUBSCRIBEDCASESSOURCES')">
                            <xsl:apply-templates/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:element name="a">
                                <xsl:attribute name="class">
                                    <xsl:text>external</xsl:text>
                                </xsl:attribute>
                                <xsl:attribute name="href">
                                    <xsl:text>looseleaf://...citeref?ctype=</xsl:text>
                                    <xsl:text>case&amp;element=citefrag_span</xsl:text>
                                    <xsl:if
                                        test="./ancestor::ci:cite/ci:case/ci:caseinfo/ci:decisiondate/@year">
                                        <xsl:text>&amp;decisiondate_year=</xsl:text>
                                        <xsl:value-of
                                            select="normalize-space(./ancestor::ci:cite/ci:case/ci:caseinfo/ci:decisiondate/@year)"
                                        />
                                    </xsl:if>
                                    <xsl:text>&amp;caseref_ID=</xsl:text>
                                    <xsl:value-of select="substring-before(./@spanid, '-')"/>
                                    <xsl:text>&amp;caseref_spanref=</xsl:text>
                                    <xsl:value-of select="./@spanid"/>
                                    <xsl:if
                                        test="./ancestor::ci:cite//ci:caseref[@spanref = $spanid]/@anaphref">
                                        <xsl:text>&amp;caseref_anaphref=</xsl:text>
                                        <xsl:value-of select="substring-before(./@spanid, '-')"/>
                                        <xsl:if
                                            test="./ancestor::ci:cite//ci:caseref[@anaphref = substring-before($spanid, '-')]/@status">
                                            <xsl:text>&amp;caseref_status=</xsl:text>
                                            <xsl:value-of
                                                select="./ancestor::ci:cite//ci:caseref[@anaphref = substring-before($spanid, '-')]/@status"
                                            />
                                        </xsl:if>
                                        <xsl:if
                                            test="./ancestor::ci:cite//ci:caseref[@ID = substring-before($spanid, '-')]/ci:reporter/@value">
                                            <xsl:text>&amp;reporter_value=</xsl:text>
                                            <xsl:variable name="reporter_value">
                                                <xsl:call-template name="string-replace">
                                                  <xsl:with-param name="string"
                                                  select="./ancestor::ci:cite//ci:caseref[@ID = substring-before($spanid, '-')]/ci:reporter/@value"/>
                                                  <xsl:with-param name="replace" select="' '"/>
                                                  <xsl:with-param name="with" select="'%20'"/>
                                                </xsl:call-template>
                                            </xsl:variable>
                                            <xsl:value-of select="$reporter_value"/>
                                        </xsl:if>
                                        <xsl:if
                                            test="./ancestor::ci:cite//ci:caseref[@ID = substring-before($spanid, '-')]/ci:edition/ci:date/@year">
                                            <xsl:text>&amp;date_year=</xsl:text>
                                            <xsl:value-of
                                                select="./ancestor::ci:cite//ci:caseref[@ID = substring-before($spanid, '-')]/ci:edition/ci:date/@year"
                                            />
                                        </xsl:if>
                                        <xsl:if
                                            test="./ancestor::ci:cite//ci:caseref[@ID = substring-before($spanid, '-')]/ci:volume/@num">
                                            <xsl:text>&amp;volume_num=</xsl:text>
                                            <xsl:value-of
                                                select="./ancestor::ci:cite//ci:caseref[@ID = substring-before($spanid, '-')]/ci:volume/@num"
                                            />
                                        </xsl:if>
                                        <xsl:if
                                            test="./ancestor::ci:cite//ci:caseref[@ID = substring-before($spanid, '-')]/ci:page/@num">
                                            <xsl:text>&amp;page_num=</xsl:text>
                                            <xsl:value-of
                                                select="./ancestor::ci:cite//ci:caseref[@ID = substring-before($spanid, '-')]/ci:page/@num"
                                            />
                                        </xsl:if>
                                        <xsl:if
                                            test="./ancestor::ci:cite//ci:caseref[@ID = substring-before($spanid, '-')]/ci:refnum/@num">
                                            <xsl:text>&amp;refnum_num=</xsl:text>
                                            <xsl:value-of
                                                select="./ancestor::ci:cite//ci:caseref[@ID = substring-before($spanid, '-')]/ci:refnum/@num"
                                            />
                                        </xsl:if>
                                        <xsl:if
                                            test="./ancestor::ci:cite//ci:caseref[@spanref = $spanid]/ci:pinpoint">
                                            <xsl:text>&amp;pinpoint_num=</xsl:text>
                                            <xsl:value-of
                                                select="./ancestor::ci:cite//ci:caseref[@spanref = $spanid]/ci:pinpoint/@num"/>
                                            <xsl:text>&amp;pinpoint_targettype=</xsl:text>
                                            <xsl:value-of
                                                select="./ancestor::ci:cite//ci:caseref[@spanref = $spanid]/ci:pinpoint/@targettype"
                                            />
                                        </xsl:if>
                                    </xsl:if>
                                    <xsl:if
                                        test="./ancestor::ci:cite//ci:caseref[@spanref = $spanid]/ci:reporter/@value">
                                        <xsl:text>&amp;reporter_value=</xsl:text>
                                        <xsl:variable name="reporter_value">
                                            <xsl:call-template name="string-replace">
                                                <xsl:with-param name="string"
                                                  select="./ancestor::ci:cite//ci:caseref[@ID = substring-before($spanid, '-')]/ci:reporter/@value"/>
                                                <xsl:with-param name="replace" select="' '"/>
                                                <xsl:with-param name="with" select="'%20'"/>
                                            </xsl:call-template>
                                        </xsl:variable>
                                        <xsl:value-of select="$reporter_value"/>
                                    </xsl:if>
                                    <xsl:if
                                        test="./ancestor::ci:cite//ci:caseref[@spanref = $spanid]/ci:refnum/@num">
                                        <xsl:text>&amp;refnum_num=</xsl:text>
                                        <xsl:value-of
                                            select="normalize-space(./ancestor::ci:cite//ci:caseref[@spanref = $spanid]/ci:refnum/@num)"
                                        />
                                    </xsl:if>
                                    <xsl:if
                                        test="./ancestor::ci:cite//ci:caseref[@spanref = $spanid]/ci:edition/ci:date/@year">
                                        <xsl:text>&amp;date_year=</xsl:text>
                                        <xsl:value-of
                                            select="normalize-space(./ancestor::ci:cite//ci:caseref[@spanref = $spanid]/ci:edition/ci:date/@year)"
                                        />
                                    </xsl:if>
                                    <xsl:if
                                        test="./ancestor::ci:cite//ci:caseref[@spanref = $spanid]/ci:volume/@num">
                                        <xsl:text>&amp;volume_num=</xsl:text>
                                        <xsl:value-of
                                            select="normalize-space(./ancestor::ci:cite//ci:caseref[@spanref = $spanid]/ci:volume/@num)"
                                        />
                                    </xsl:if>
                                    <xsl:if
                                        test="./ancestor::ci:cite//ci:caseref[@spanref = $spanid]/ci:page/@num">
                                        <xsl:text>&amp;page_num=</xsl:text>
                                        <xsl:value-of
                                            select="normalize-space(./ancestor::ci:cite//ci:caseref[@spanref = $spanid]/ci:page/@num)"
                                        />
                                    </xsl:if>
                                    <xsl:text>&amp;book_country=</xsl:text>
                                    <xsl:value-of select="//docinfo:doc-country/@iso-cc"/>
                                    <xsl:choose>
                                        <xsl:when test="./inlineobject"/>
                                        <xsl:otherwise>
                                            <xsl:text>&amp;LinkName=</xsl:text>
                                            <xsl:value-of select="$repalced-string"/>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </xsl:attribute>
                                <xsl:apply-templates/>
                            </xsl:element>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:if>
    </xsl:template>


    <!-- Template to transform insert-line   -->
    <xsl:template match="insert-line">
        <xsl:element name="span">
            <xsl:call-template name="spanid"/>
            <xsl:value-of select="@character"/>
        </xsl:element>
    </xsl:template>

    <!--  Template to transform form-chars  -->
    <xsl:template match="form-chars">
        <xsl:variable name="num-char" select="./@num-char"/>
        <xsl:variable name="char" select="./@character"/>
        <xsl:element name="span">
            <xsl:call-template name="spanid"/>
            <xsl:call-template name="loop">
                <xsl:with-param name="var">
                    <xsl:value-of select="$num-char"/>
                </xsl:with-param>
                <xsl:with-param name="charval">
                    <xsl:value-of select="./@character"/>
                </xsl:with-param>
            </xsl:call-template>
        </xsl:element>
    </xsl:template>

    <!-- Template to create loop for form-char character   -->
    <xsl:template name="loop">
        <xsl:param name="var"/>
        <xsl:param name="charval"/>
        <xsl:choose>
            <xsl:when test="$var &gt; 0">
                <xsl:value-of select="$charval"/>
                <xsl:call-template name="loop">
                    <xsl:with-param name="var">
                        <xsl:number value="number($var) - 1"/>
                    </xsl:with-param>
                    <xsl:with-param name="charval">
                        <xsl:value-of select="$charval"/>
                    </xsl:with-param>
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise> </xsl:otherwise>
        </xsl:choose>
    </xsl:template>


    <!--  Template to transform l  -->
    <xsl:template match="l">
        <xsl:if test="child::node()">
            <xsl:element name="ul">
                <xsl:apply-templates/>
            </xsl:element>
        </xsl:if>
    </xsl:template>


    <!--  Template to transform li  -->
    <xsl:template match="li">
        <xsl:if test="child::node()">
            <xsl:element name="li">
                <xsl:if test="./@id">
                    <xsl:element name="div">
                        <xsl:attribute name="class">
                            <xsl:text>hiddendiv</xsl:text>
                        </xsl:attribute>
                        <xsl:attribute name="data-value">
                            <xsl:value-of select="@id"/>
                        </xsl:attribute>
                    </xsl:element>
                </xsl:if>
                <xsl:apply-templates/>
            </xsl:element>
        </xsl:if>
    </xsl:template>


    <!--  Template to transform lilabel  -->
    <xsl:template match="lilabel">
        <xsl:element name="span">
            <xsl:attribute name="class">
                <xsl:text>lilabel</xsl:text>
            </xsl:attribute>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>


    <!-- Template to transform sup   -->
    <xsl:template match="sup">
        <xsl:if test="child::node()">
            <xsl:element name="sup">
                <xsl:apply-templates/>
            </xsl:element>
        </xsl:if>
    </xsl:template>

    <!-- Template to transform sub   -->
    <xsl:template match="sub">
        <xsl:if test="child::node()">
            <xsl:element name="sub">
                <xsl:apply-templates/>
            </xsl:element>
        </xsl:if>
    </xsl:template>


    <!--  Template to transform emph  -->
    <xsl:template match="emph">
        <xsl:if test="child::node()">
            <xsl:element name="span">
                <xsl:attribute name="class">
                    <xsl:value-of select="@typestyle"/>
                </xsl:attribute>
                <xsl:apply-templates/>
            </xsl:element>
        </xsl:if>
    </xsl:template>

    <!-- Template to transform strike   -->
    <xsl:template match="strike">
        <xsl:if test="child::node()">
            <xsl:element name="span">
                <xsl:attribute name="class">
                    <xsl:value-of select="@typestyle"/>
                </xsl:attribute>
                <xsl:apply-templates/>
            </xsl:element>
        </xsl:if>
    </xsl:template>


    <!--  Template To Transform leg:officialname  -->
    <xsl:template match="leg:officialname">
        <xsl:if test="child::node()">
            <xsl:element name="h3">
                <xsl:apply-templates/>
            </xsl:element>
        </xsl:if>
    </xsl:template>

    <!--  Template to transform leg:histnote  -->
    <xsl:template match="leg:histnote">
        <xsl:if test="child::node()">
            <xsl:element name="div">
                <xsl:attribute name="class">
                    <xsl:text>histnote</xsl:text>
                </xsl:attribute>
                <xsl:apply-templates/>
            </xsl:element>
        </xsl:if>
    </xsl:template>

    <!--  Template to transform blockquote  -->
    <xsl:template match="blockquote">
        <xsl:if test="child::node()">
            <xsl:element name="blockquote">
                <xsl:apply-templates/>
            </xsl:element>
        </xsl:if>
    </xsl:template>


    <!--  Template to transform fnr  -->
    <xsl:template match="fnr">
        <xsl:if test="child::node()">
            <xsl:element name="sup">
                <xsl:element name="a">
                    <xsl:attribute name="class">
                        <xsl:text>interbook</xsl:text>
                    </xsl:attribute>
                    <xsl:attribute name="id">
                        <xsl:value-of select="./@fntoken"/>
                        <xsl:text>-fnr</xsl:text>
                    </xsl:attribute>
                    <xsl:attribute name="href">
                        <xsl:text>#</xsl:text>
                        <xsl:value-of select="./@fnrtoken"/>
                    </xsl:attribute>
                    <xsl:attribute name="data-fntoken">
                        <xsl:value-of select="./@fntoken"/>
                    </xsl:attribute>
                    <xsl:attribute name="data-fnrtoken">
                        <xsl:value-of select="./@fnrtoken"/>
                    </xsl:attribute>
                    <xsl:element name="span">
                        <xsl:attribute name="class">
                            <xsl:text>fnr</xsl:text>
                        </xsl:attribute>
                        <xsl:element name="span">
                            <xsl:call-template name="spanid"/>
                            <xsl:value-of select="."/>
                        </xsl:element>
                    </xsl:element>
                </xsl:element>
            </xsl:element>
        </xsl:if>
    </xsl:template>


    <!-- Template to transfrom footnotegrp   -->
    <xsl:template match="footnotegrp">
        <xsl:if test="child::node()">
            <xsl:element name="div">
                <xsl:attribute name="class">
                    <xsl:text>footnotelist</xsl:text>
                </xsl:attribute>
                <xsl:apply-templates/>
            </xsl:element>
        </xsl:if>
    </xsl:template>


    <!-- Template to transfrom footnote   -->
    <xsl:template match="footnote">
        <xsl:if test="child::node()">
            <xsl:element name="div">
                <xsl:attribute name="class">
                    <xsl:text>footnote</xsl:text>
                </xsl:attribute>
                <xsl:apply-templates/>
            </xsl:element>
        </xsl:if>
    </xsl:template>


    <!--  Template to transform fnlabel  -->
    <xsl:template match="fnlabel">
        <xsl:if test="child::node()">
            <xsl:element name="a">
                <xsl:attribute name="id">
                    <xsl:value-of select="parent::footnote/@fnrtokens"/>
                </xsl:attribute>
                <xsl:attribute name="data-fntoken">
                    <xsl:value-of select="parent::footnote/@fntoken"/>
                </xsl:attribute>
                <xsl:attribute name="href">
                    <xsl:text>#</xsl:text>
                    <xsl:value-of select="./parent::footnote/@fntoken"/>
                    <xsl:text>-fnr</xsl:text>
                </xsl:attribute>
                <xsl:element name="span">
                    <xsl:attribute name="class">
                        <xsl:text>fnlabel</xsl:text>
                    </xsl:attribute>
                    <xsl:apply-templates/>
                </xsl:element>
            </xsl:element>
        </xsl:if>
    </xsl:template>
    <!-- add by Manju for hiding Penal Code reported by Annie in HLS -->
    <xsl:template match="note">
        <xsl:choose>
            <xsl:when test="@ln.user-displayed = 'false'">
                <xsl:element name="div">
                    <xsl:attribute name="class">
                        <xsl:text>hiddendiv</xsl:text>
                    </xsl:attribute>
                    <xsl:apply-templates/>
                </xsl:element>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates/>
            </xsl:otherwise>
        </xsl:choose>
        
    </xsl:template>
    <!-- End -->
    <!--  Template to Transform text/text()   -->
    <xsl:template
        match="text/text() | ci:content/text() | entry/text() | emph/text() | citefragment/text() | docinfo:currencystatement/text() | title/text() | edpnum/text() | leg:empleg/text() | designum/text() | ci:span/text() | lilabel/text() | sup/text() | sub/text() | leg:officialname/text() | date/text() | remotelink/text() | link/text() | defitem/text() | contrib/text() | classname/text() | name.text/text() | dispformula/text() | frac/text() | numer/text() | denom/text() | num/text() | fnlabel/text() | desiglabel/text() | p-limited/text()">
        <xsl:choose>
            <xsl:when
                test="parent::designum | parent::edpnum | parent::leg:empleg | parent::desiglabel">
                <xsl:choose>
                    <xsl:when test="contains(., '&#x2003;')">
                        <xsl:element name="span">
                            <xsl:call-template name="spanid"/>
                            <xsl:value-of select="normalize-space(.)"/>
                        </xsl:element>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:element name="span">
                            <xsl:call-template name="spanid"/>
                            <xsl:value-of select="concat(normalize-space(.), '&#x2003;')"/>
                        </xsl:element>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
                <xsl:element name="span">
                    <xsl:call-template name="spanid"/>
                    <xsl:value-of select="translate(., '&#10;&#13;', '')"/>
                </xsl:element>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!--  Template to Transform table  -->
    <xsl:template match="table">
        <xsl:if test="child::node()">
            <xsl:apply-templates/>
        </xsl:if>
    </xsl:template>

    <!-- Tamplate to transform tgroup -->
    <xsl:template match="tgroup">
        <xsl:element name="table">
            <xsl:choose>
                <xsl:when test="parent::table/@frame">
                    <xsl:attribute name="style">
                        <xsl:if test="parent::table/@frame = 'all'">
                            <xsl:text>border:1px solid;</xsl:text>
                        </xsl:if>
                        <xsl:if test="parent::table/@pgwide = '1'">
                            <xsl:text>width:100%;</xsl:text>
                        </xsl:if>
                    </xsl:attribute>
                    <xsl:if test="parent::table/@frame = 'topbot'">
                        <xsl:attribute name="class">
                            <xsl:text>topbot</xsl:text>
                        </xsl:attribute>
                    </xsl:if>
                    <xsl:if test="parent::table/@frame = 'top'">
                        <xsl:attribute name="class">
                            <xsl:text>table-top</xsl:text>
                        </xsl:attribute>
                    </xsl:if>
                    <xsl:if test="parent::table/@frame = 'bottom'">
                        <xsl:attribute name="class">
                            <xsl:text>table-bottom</xsl:text>
                        </xsl:attribute>
                    </xsl:if>
                    <xsl:if test="parent::table/@frame = 'sides'">
                        <xsl:attribute name="class">
                            <xsl:text>table-sides</xsl:text>
                        </xsl:attribute>
                    </xsl:if>
                    <xsl:if test="parent::table/@id">
                        <xsl:attribute name="id">
                            <xsl:value-of select="parent::table/@id"/>
                        </xsl:attribute>
                    </xsl:if>
                    <xsl:if test="parent::table/child::title">
                        <xsl:element name="caption">
                            <xsl:value-of select="parent::table/child::title"/>
                        </xsl:element>
                    </xsl:if>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:attribute name="style">
                        <xsl:text>border:1px solid;</xsl:text>
                        <xsl:if test="parent::table/@pgwide = '1'">
                            <xsl:text>width:100%;</xsl:text>
                        </xsl:if>
                    </xsl:attribute>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:element name="colgroup">
                <xsl:apply-templates select="colspec"/>
            </xsl:element>
            <xsl:apply-templates select="*[name(.) != 'colspec']"/>
        </xsl:element>
    </xsl:template>

    <!-- Template to transform colspec    -->
    <xsl:template match="colspec">
        <xsl:element name="col">
            <xsl:attribute name="style">
                <xsl:if test="@align">
                    <xsl:value-of select="concat('text-align:', @align, ';')"/>
                </xsl:if>
                <xsl:if test="@colwidth">
                    <xsl:variable name="check" select="parent::tgroup/child::colspec/@colwidth"/>
                    <xsl:variable name="allnum">
                        <xsl:for-each select="$check">
                            <xsl:value-of select="."/>
                        </xsl:for-each>
                    </xsl:variable>
                    <xsl:variable name="width">
                        <xsl:value-of select="@colwidth"/>
                    </xsl:variable>
                    <xsl:variable name="widthvalue" select="ext:Getwidth($width, $allnum)"/>
                    <xsl:choose>
                        <!--RC-161 Date 11 Nov 2017 by Surendra-->
                        <xsl:when test="substring(@colwidth, string-length(@colwidth) - 1) = 'in'">
                            <xsl:call-template name="ConvToPixel">
                                <xsl:with-param name="colwidth" select="@colwidth"/>
                            </xsl:call-template>
                        </xsl:when>
                        <!--End-->
                        <xsl:when test="contains($widthvalue, '.')">
                            <xsl:value-of
                                select="concat('width:', ext:Getwidth($width, $allnum), '%;')"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of
                                select="concat('width:', ext:Getwidth($width, $allnum), '.000000%;')"
                            />
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:if>
            </xsl:attribute>
            <!--RC-161 Date 11 Nov 2017 by Surendra-->
            <xsl:choose>
                <xsl:when test="substring(@colwidth, string-length(@colwidth) - 1) = 'in'">
                    <xsl:attribute name="width">
                        <xsl:call-template name="ConvToPixel">
                            <xsl:with-param name="colwidth" select="@colwidth"/>
                        </xsl:call-template>

                    </xsl:attribute>
                </xsl:when>
            </xsl:choose>
            <!--End-->
        </xsl:element>
    </xsl:template>

    <!--  Template to transform tbody  -->
    <xsl:template match="tbody">
        <xsl:if test="child::node()">
            <xsl:element name="tbody">
                <xsl:if test="@valign">
                    <xsl:attribute name="class">
                        <xsl:value-of select="concat('valign-', @valign)"/>
                    </xsl:attribute>
                </xsl:if>
                <xsl:apply-templates/>
            </xsl:element>
        </xsl:if>
    </xsl:template>

    <!--  Template to transform tbody  -->
    <xsl:template match="thead">
        <xsl:if test="child::node()">
            <xsl:element name="thead">
                <xsl:if test="@valign">
                    <xsl:attribute name="class">
                        <xsl:value-of select="concat('valign-', @valign)"/>
                    </xsl:attribute>
                </xsl:if>
                <xsl:apply-templates/>
            </xsl:element>
        </xsl:if>
    </xsl:template>

    <!--  Template to transform row  -->
    <!--<xsl:template match="row">
        <xsl:if test="child::node()">
            <xsl:element name="tr">
                <xsl:apply-templates/>
            </xsl:element>
        </xsl:if>
    </xsl:template>-->

    <!--  Template to transform row  -->
    <xsl:template match="row">
        <xsl:if test="child::node()">
            <xsl:element name="tr">
                <xsl:apply-templates/>
            </xsl:element>
        </xsl:if>
    </xsl:template>

    <!-- Template to transform entry    -->
    <xsl:template match="entry">
        <xsl:choose>
            <xsl:when test="ancestor::thead">
                <xsl:element name="th">
                    <xsl:if test="@namest or @nameend">
                        <xsl:variable name="check" select="ancestor::tgroup/child::colspec/@colname"/>
                        <xsl:variable name="allcolname">
                            <xsl:for-each select="$check">
                                <xsl:value-of select="concat(., '*')"/>
                            </xsl:for-each>
                        </xsl:variable>
                        <xsl:variable name="namest">
                            <xsl:value-of select="@namest"/>
                        </xsl:variable>
                        <xsl:variable name="nameend">
                            <xsl:value-of select="@nameend"/>
                        </xsl:variable>
                        <xsl:attribute name="colspan">
                            <xsl:value-of
                                select="ext:GetColSpanValue($allcolname, $namest, $nameend)"/>
                        </xsl:attribute>
                    </xsl:if>
                    <xsl:if test="@morerows &gt;= '1'">
                        <xsl:attribute name="rowspan">
                            <xsl:value-of select="@morerows + 1"/>
                        </xsl:attribute>
                    </xsl:if>
                    <xsl:if
                        test="@align or @rowsep &gt;= '1' or @colsep &gt;= '1' or ./parent::row/@rowsep &gt;= '1'">
                        <xsl:attribute name="style">
                            <xsl:if test="@align">
                                <xsl:value-of select="concat('text-align:', @align, ';')"/>
                            </xsl:if>
                            <xsl:if test="@rowsep &gt;= '1' or ./parent::row/@rowsep &gt;= '1'">
                                <xsl:text>border-bottom:1pt solid black;</xsl:text>
                            </xsl:if>
                            <xsl:if
                                test="./ancestor::table/@frame = 'all' and not(following-sibling::node())">
                                <xsl:text>border-right:1pt solid black;</xsl:text>
                            </xsl:if>
                            <xsl:if
                                test="@colsep &gt;= '1' and name(following-sibling::node()) = 'entry'">
                                <xsl:text>border-right:1pt solid black;</xsl:text>
                            </xsl:if>
                        </xsl:attribute>
                    </xsl:if>
                    <xsl:if test="@valign">
                        <xsl:attribute name="class">
                            <xsl:value-of select="concat('valign-', @valign)"/>
                        </xsl:attribute>
                    </xsl:if>
                    <xsl:apply-templates/>
                </xsl:element>
            </xsl:when>
            <xsl:otherwise>
                <xsl:element name="td">
                    <xsl:if test="@namest or @nameend">
                        <xsl:variable name="check" select="ancestor::tgroup/child::colspec/@colname"/>
                        <xsl:variable name="allcolname">
                            <xsl:for-each select="$check">
                                <xsl:value-of select="concat(., '*')"/>
                            </xsl:for-each>
                        </xsl:variable>
                        <xsl:variable name="namest">
                            <xsl:value-of select="@namest"/>
                        </xsl:variable>
                        <xsl:variable name="nameend">
                            <xsl:value-of select="@nameend"/>
                        </xsl:variable>
                        <xsl:attribute name="colspan">
                            <xsl:value-of
                                select="ext:GetColSpanValue($allcolname, $namest, $nameend)"/>
                        </xsl:attribute>
                    </xsl:if>
                    <xsl:if test="@morerows &gt;= '1'">
                        <xsl:attribute name="rowspan">
                            <xsl:value-of select="@morerows + 1"/>
                        </xsl:attribute>
                    </xsl:if>
                    <xsl:if
                        test="@align or @rowsep &gt;= '1' or @colsep &gt;= '1' or ./parent::row/@rowsep &gt;= '1' or ./ancestor::tgroup/colspec/@colwidth">
                        <xsl:attribute name="style">
                            <xsl:if test="@align">
                                <xsl:value-of select="concat('text-align:', @align, ';')"/>
                            </xsl:if>
                            <xsl:if test="@rowsep &gt;= '1' or ./parent::row/@rowsep &gt;= '1'">
                                <xsl:text>border-bottom:1pt solid black;</xsl:text>
                            </xsl:if>
                            <xsl:if
                                test="./ancestor::table/@frame = 'all' and not(following-sibling::node())">
                                <xsl:text>border-right:1pt solid black;</xsl:text>
                            </xsl:if>
                            <xsl:if
                                test="@colsep &gt;= '1' and name(following-sibling::node()) = 'entry'">
                                <xsl:text>border-right:1pt solid black;</xsl:text>
                            </xsl:if>
                        </xsl:attribute>
                    </xsl:if>
                    <xsl:if
                        test="substring(./ancestor::tgroup[1]/colspec[1]/@colwidth, string-length(./ancestor::tgroup[1]/colspec[1]/@colwidth) - 1) = 'in'">
                        <xsl:attribute name="width">
                            <xsl:variable name="check"
                                select="ancestor::tgroup/child::colspec/@colname"/>
                            <xsl:variable name="allcolname">
                                <xsl:for-each select="$check">
                                    <xsl:value-of select="concat(., '*')"/>
                                </xsl:for-each>
                            </xsl:variable>
                            <xsl:call-template name="getcolwidth">
                                <xsl:with-param name="allcol"
                                    select="./ancestor::tgroup[1]/child::colspec"/>
                                <xsl:with-param name="naMend" select="@nameend"/>
                                <xsl:with-param name="naMest" select="@namest"/>
                                <xsl:with-param name="allCols" select="$allcolname"/>
                                <xsl:with-param name="precCols" select="./preceding-sibling::entry"/>

                            </xsl:call-template>

                        </xsl:attribute>

                    </xsl:if>
                    <xsl:if test="@valign">
                        <xsl:attribute name="class">
                            <xsl:value-of select="concat('valign-', @valign)"/>
                        </xsl:attribute>
                    </xsl:if>
                    <xsl:apply-templates/>
                </xsl:element>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!--  Template to transform remotelink  -->
    <xsl:template match="remotelink">
        <xsl:if test="child::node()">
            <xsl:variable name="repalced-string">
                <xsl:call-template name="string-replace">
                    <xsl:with-param name="string">
                        <xsl:call-template name="string-replace">
                            <xsl:with-param name="string">
                                <xsl:call-template name="string-replace">
                                    <xsl:with-param name="string">
                                        <xsl:call-template name="string-replace">
                                            <xsl:with-param name="string">
                                                <xsl:call-template name="string-replace">
                                                  <xsl:with-param name="string"
                                                  select="normalize-space(.)"/>
                                                  <xsl:with-param name="replace" select="' '"/>
                                                  <xsl:with-param name="with" select="'%20'"/>
                                                </xsl:call-template>
                                            </xsl:with-param>
                                            <xsl:with-param name="replace" select="'['"/>
                                            <xsl:with-param name="with" select="'%5B;'"/>
                                        </xsl:call-template>
                                    </xsl:with-param>
                                    <xsl:with-param name="replace" select="']'"/>
                                    <xsl:with-param name="with" select="'%5D;'"/>
                                </xsl:call-template>
                            </xsl:with-param>
                            <xsl:with-param name="replace" select="'('"/>
                            <xsl:with-param name="with" select="'%28;'"/>
                        </xsl:call-template>
                    </xsl:with-param>
                    <xsl:with-param name="replace" select="')'"/>
                    <xsl:with-param name="with" select="'%29;'"/>
                </xsl:call-template>
            </xsl:variable>
            <xsl:choose>
                <xsl:when test="@href">
                    <xsl:element name="a">
                        <xsl:attribute name="class">
                            <xsl:text>external</xsl:text>
                        </xsl:attribute>
                        <xsl:attribute name="href">
                            <xsl:variable name="href-string">
                                <xsl:call-template name="string-replace">
                                    <xsl:with-param name="string" select="@href"/>
                                    <xsl:with-param name="replace" select="' '"/>
                                    <xsl:with-param name="with" select="''"/>
                                </xsl:call-template>
                            </xsl:variable>
                            <xsl:value-of select="$href-string"/>
                        </xsl:attribute>
                        <xsl:apply-templates/>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="./@status='unval'">
                    <xsl:element name="span">
                        <xsl:attribute name="class">
                            <xsl:text>span-link</xsl:text>
                        </xsl:attribute>
                        <xsl:apply-templates/>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="not(./@dpsi) or ./@dpsi = ''">
                    <xsl:element name="span">
                        <xsl:attribute name="class">
                            <xsl:text>span-link</xsl:text>
                        </xsl:attribute>
                        <xsl:apply-templates/>
                    </xsl:element>
                </xsl:when>
                <xsl:when test="(not(./@refpt) or ./@refpt = '') and (not(./@remotekey2) or (./@remotekey2) ='')">
                    <xsl:element name="span">
                        <xsl:attribute name="class">
                            <xsl:text>span-link</xsl:text>
                        </xsl:attribute>
                        <xsl:apply-templates/>
                    </xsl:element>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:element name="a">
                        <xsl:attribute name="class">
                            <xsl:text>external</xsl:text>
                        </xsl:attribute>
                        <xsl:attribute name="href">
                            <xsl:text>looseleaf://opendocument?dpsi=</xsl:text>
                            <xsl:value-of select="./@dpsi"/>
                            <xsl:text>&amp;refpt=</xsl:text>
                            <xsl:value-of select="./@refpt"/>
                            <xsl:text>&amp;remotekey1=</xsl:text>
                            <xsl:value-of select="./@remotekey1"/>
                            <xsl:if test="@remotekey2">
                                <xsl:text>&amp;remotekey2=</xsl:text>
                                <xsl:variable name="replaced_remotekey2">
                                    <xsl:call-template name="string-replace">
                                        <xsl:with-param name="string"
                                            select="normalize-space(@remotekey2)"/>
                                        <xsl:with-param name="replace" select="' '"/>
                                        <xsl:with-param name="with" select="'%20'"/>
                                    </xsl:call-template>
                                </xsl:variable>
                                <xsl:value-of select="$replaced_remotekey2"/>
                            </xsl:if>
                            <xsl:text>&amp;service=</xsl:text>
                            <xsl:value-of select="./@service"/>
                            <xsl:text>&amp;book_country=</xsl:text>
                            <xsl:value-of select="//docinfo:doc-country/@iso-cc"/>
                            <xsl:choose>
                                <xsl:when test="./inlineobject"/>
                                <xsl:otherwise>
                                    <xsl:text>&amp;LinkText=</xsl:text>
                                    <xsl:value-of select="$repalced-string"/>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:attribute>
                        <xsl:choose>
                            <xsl:when test="./child::inlineobject">
                                <xsl:element name="img">
                                    <!-- <xsl:attribute name="src">
                                        <xsl:value-of select="./inlineobject/@filename"/>
                                    </xsl:attribute>-->
                                    <!-- change for img element -->
                                    <xsl:choose>
                                        <xsl:when
                                            test="./child::inlineobject/@filename = 'cbcc.gif' or ./child::inlineobject/@filename = 'cb.png' or ./child::inlineobject/@filename = 'nzcitator.gif' or ./child::inlineobject/@filename = 'leg1.gif'">
                                            <xsl:attribute name="src">
                                                <xsl:value-of
                                                  select="./child::inlineobject/@filename"/>
                                            </xsl:attribute>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:attribute name="src">
                                                <xsl:value-of
                                                  select="concat('##file://inlineobjectlocalpath##', ./child::inlineobject/@filename)"
                                                />
                                            </xsl:attribute>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                    <xsl:attribute name="alt">
                                        <xsl:choose>
                                            <!-- <xsl:when test="@alttext">
                                                <xsl:value-of select="@alttext"/>
                                            </xsl:when>-->
                                            <xsl:when test="./inlineobject/@alttext">
                                                <xsl:value-of select="./inlineobject/@alttext"/>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <xsl:text>image</xsl:text>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </xsl:attribute>
                                </xsl:element>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:apply-templates/>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:element>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:if>
    </xsl:template>

    <!-- Template To transform date   -->
    <xsl:template match="date">
        <xsl:if test="child::node()">
            <xsl:apply-templates/>
        </xsl:if>
    </xsl:template>

    <!-- Template to transform leg:comntry    -->
    <xsl:template match="leg:comntry">
        <xsl:element name="aside">
            <xsl:attribute name="class">
                <xsl:text>comntry</xsl:text>
            </xsl:attribute>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>

    <!--  template to transform dispformula   -->
    <xsl:template match="dispformula">
        <xsl:if test="child::node()">
            <xsl:element name="span">
                <xsl:attribute name="class">
                    <xsl:text>dispformula</xsl:text>
                </xsl:attribute>
                <xsl:apply-templates/>
            </xsl:element>
        </xsl:if>
    </xsl:template>

    <!--  template to transform frac   -->
    <xsl:template match="frac">
        <xsl:if test="child::node()">
            <xsl:element name="span">
                <xsl:attribute name="class">
                    <xsl:text>frac</xsl:text>
                </xsl:attribute>
                <xsl:apply-templates/>
            </xsl:element>
        </xsl:if>
    </xsl:template>

    <!--  template to transform numer   -->
    <xsl:template match="numer">
        <xsl:if test="child::node()">
            <xsl:element name="span">
                <xsl:attribute name="class">
                    <xsl:text>numer</xsl:text>
                </xsl:attribute>
                <xsl:apply-templates/>
            </xsl:element>
        </xsl:if>
    </xsl:template>

    <!--  template to transform numer   -->
    <xsl:template match="num">
        <xsl:if test="child::node()">
            <xsl:element name="span">
                <xsl:attribute name="class">
                    <xsl:text>num</xsl:text>
                </xsl:attribute>
                <xsl:apply-templates/>
            </xsl:element>
        </xsl:if>
    </xsl:template>

    <!--  template to transform denom   -->
    <xsl:template match="denom">
        <xsl:if test="child::node()">
            <xsl:element name="span">
                <xsl:attribute name="class">
                    <xsl:text>denom</xsl:text>
                </xsl:attribute>
                <xsl:apply-templates/>
            </xsl:element>
        </xsl:if>
    </xsl:template>


    <!--  template to transform link  -->
    <xsl:template match="link">
        <xsl:if test="child::node()">
            <!-- Updated by keshav kumar for RC-510 05/07/2018 -->
            <xsl:choose>
                <xsl:when test="(ancestor::*[last()][self::COMMENTARYDOC] and //docinfo:doc-country/@iso-cc='NZ' and normalize-space(translate(., 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz'))='download in pdf') and (contains(//docinfo:metaitem[@name='lbu-sourcename']/@value, ' (book)') or //page)"/>
                <xsl:otherwise>
                    <xsl:element name="a">
                        <xsl:attribute name="class">
                            <xsl:text>external</xsl:text>
                        </xsl:attribute>
                        <xsl:attribute name="href">
                            <xsl:text>file://DL_FOLDER/</xsl:text>
                            <xsl:value-of select="./@filename"/>
                        </xsl:attribute>
                        <xsl:attribute name="type">
                            <xsl:text>link</xsl:text>
                        </xsl:attribute>
                        <xsl:apply-templates/>
                    </xsl:element>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:if>
    </xsl:template>


    <!--  Template to transform page  -->
    <xsl:template match="page">
        <xsl:element name="span">
            <xsl:attribute name="class">
                <xsl:text>pagebreak</xsl:text>
            </xsl:attribute>
            <xsl:attribute name="data-tag">
                <xsl:text>page</xsl:text>
            </xsl:attribute>
            <xsl:attribute name="data-count">
                <xsl:value-of select="@count"/>
            </xsl:attribute>
            <xsl:attribute name="data-reporter">
                <xsl:value-of select="@reporter"/>
            </xsl:attribute>
            <xsl:attribute name="data-text">
                <xsl:text>Page</xsl:text>
            </xsl:attribute>
            <xsl:element name="span">
                <xsl:attribute name="class">
                    <xsl:text>pagenum</xsl:text>
                </xsl:attribute>
                <xsl:element name="span">
                    <xsl:call-template name="spanid"/>
                    <xsl:text>Page </xsl:text>
                    <xsl:value-of select="@count"/>
                </xsl:element>
            </xsl:element>
        </xsl:element>
    </xsl:template>


    <!--  Template to transform hrule  -->
    <xsl:template match="hrule">
        <hr/>
    </xsl:template>

    <!--  Template to transform inlineobject  -->
    <xsl:template match="inlineobject">
        <xsl:element name="img">
            <xsl:choose>
                <xsl:when
                    test="@filename = 'cbcc.gif' or @filename = 'cb.png' or @filename = 'nzcitator.gif' or @filename = 'leg1.gif'">
                    <xsl:attribute name="src">
                        <xsl:value-of select="@filename"/>
                    </xsl:attribute>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:attribute name="src">
                        <xsl:text>##file://inlineobjectlocalpath##</xsl:text>
                        <xsl:value-of select="@filename"/>
                    </xsl:attribute>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:attribute name="attachment">
                <xsl:value-of select="@attachment"/>
            </xsl:attribute>
            <xsl:attribute name="type">
                <xsl:value-of select="@type"/>
            </xsl:attribute>
            <xsl:attribute name="alt">
                <xsl:choose>
                    <xsl:when test="@alttext">
                        <xsl:value-of select="@alttext"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text>image</xsl:text>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:attribute>
        </xsl:element>
    </xsl:template>


    <!--  Template to transform nl   -->
    <xsl:template match="nl">
        <br/>
    </xsl:template>

    <!-- Template To transform levelinfo   -->
    <xsl:template match="levelinfo">
        <xsl:if test="child::node()">
            <xsl:choose>
                <xsl:when test="@ln.user-displayed = 'false'">
                    <xsl:element name="div">
                        <xsl:attribute name="class">
                            <xsl:text>hiddendiv</xsl:text>
                        </xsl:attribute>
                        <xsl:text>  </xsl:text>
                        <xsl:apply-templates/>
                    </xsl:element>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:element name="div">
                        <xsl:attribute name="class">
                            <xsl:text>levelinfo</xsl:text>
                        </xsl:attribute>
                        <xsl:apply-templates/>
                    </xsl:element>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:if>
    </xsl:template>

    <!-- Template to transform contrib   -->
    <xsl:template match="contrib">
        <xsl:if test="child::node()">
            <xsl:choose>
                <xsl:when test="@ln.user-displayed = 'false'">
                    <xsl:element name="div">
                        <xsl:attribute name="class">
                            <xsl:text>hiddendiv</xsl:text>
                        </xsl:attribute>
                        <xsl:text>  </xsl:text>
                        <xsl:apply-templates/>
                    </xsl:element>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:element name="div">
                        <xsl:attribute name="class">
                            <xsl:text>contrib</xsl:text>
                        </xsl:attribute>
                        <xsl:apply-templates/>
                    </xsl:element>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:if>
    </xsl:template>

    <!--  Template to transform sigblock -->
    <xsl:template match="sigblock">
        <xsl:if test="child::node()">
            <xsl:element name="div">
                <xsl:attribute name="class">
                    <xsl:text>sigblock</xsl:text>
                </xsl:attribute>
                <xsl:apply-templates/>
            </xsl:element>
        </xsl:if>
    </xsl:template>

    <!--Template to transform person/role    -->
    <xsl:template match="role">
        <!--RC-260 AEFP-->
        <xsl:element name="span">
            <xsl:attribute name="style">
                <xsl:text>font-style: italic;</xsl:text>
            </xsl:attribute>
            <xsl:if test="child::node()">
				<xsl:if test="local-name(./preceding-sibling::*[1])='name.text'">
					<xsl:element name="span">
						<br/>
					</xsl:element>
				</xsl:if>			
                <xsl:apply-templates/>
                <xsl:element name="span">
                    <br/>
					<xsl:if test="local-name(./following-sibling::*[1])='name.text'">
						<br/>
					</xsl:if>
                </xsl:element>
            </xsl:if>
        </xsl:element>
        <!--End-->
    </xsl:template>
	<!--RC-260 AEFP-->
    <!--Template to transform name.detail/name.degree    -->
    <xsl:template match="name.degree">
        <xsl:element name="span">
            <xsl:attribute name="style">
                <xsl:text>font-style: italic;</xsl:text>
            </xsl:attribute>
            <xsl:if test="child::node()">
				<xsl:if test="local-name(./parent::*/preceding-sibling::*[1])='name.text'">
					<xsl:element name="span">
						<br/>
					</xsl:element>
				</xsl:if>
                <xsl:apply-templates/>
				<xsl:element name="span">
					<br/>
                </xsl:element>
            </xsl:if>
        </xsl:element>
    </xsl:template>
	<!--End-->

    <!--Template to transform person/role    -->
    <xsl:template match="name.text">
        <!--RC-260 AEFP-->
        <xsl:element name="span">
            <xsl:attribute name="style">
                <xsl:text>font-size: 15px;font-weight: 700;</xsl:text>
            </xsl:attribute>
            <xsl:if test="child::node()">
                <xsl:apply-templates/>
                <xsl:element name="span">
                    <br/>
                </xsl:element>
            </xsl:if>
        </xsl:element>
        <!--End-->
    </xsl:template>

    <!-- Template to trasnform docinfo:currencystatement  -->
    <xsl:template match="docinfo:currencystatement">
        <xsl:if test="child::node()">
            <xsl:element name="p">
                <xsl:apply-templates/>
            </xsl:element>
        </xsl:if>
    </xsl:template>

    <!-- Tamplate to transform classification -->
    <xsl:template match="classification">
        <xsl:if test="child::node()">
            <xsl:element name="div">
                <xsl:if test="@ln.user-displayed = 'false'">
                    <!--RC-258 AEFP-->
                    <xsl:attribute name="class">
                        <xsl:text>hiddendiv</xsl:text>
                    </xsl:attribute>
                    <!--End-->
                </xsl:if>
                <xsl:apply-templates/>
            </xsl:element>
        </xsl:if>

    </xsl:template>

    <!-- Tamplate to transform classification -->
    <xsl:template match="classitem">
        <xsl:if test="child::node()">
            <xsl:element name="div">
                <xsl:if test="@ln.user-displayed = 'false'">
                    <!--RC-258 AEFP-->
                    <xsl:attribute name="class">
                        <xsl:text>hiddendiv</xsl:text>
                    </xsl:attribute>
                    <!--End-->
                </xsl:if>
                <xsl:apply-templates/>
            </xsl:element>
        </xsl:if>
    </xsl:template>

    <!-- Template to transfor p-limited   -->
    <xsl:template match="p-limited">
        <xsl:element name="span">
            <xsl:attribute name="class">
                <xsl:text>p-limited</xsl:text>
            </xsl:attribute>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>

    <!--  Template to genrate xPath  -->
    <xsl:template name="getXpath">
        <xsl:text>/</xsl:text>
        <xsl:for-each select="ancestor-or-self::*">
            <xsl:value-of select="name()"/>
            <xsl:if
                test="count(following-sibling::*[name(.) = name(current())]) != 0 or count(preceding-sibling::*[name(.) = name(current())]) != 0">
                <xsl:value-of
                    select="concat('[', 1 + count(preceding-sibling::*[name(.) = name(current())]), ']')"
                />
            </xsl:if>
            <xsl:choose>
                <xsl:when test="not(position() = last())">
                    <xsl:text>/</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>/text()</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:for-each>
        <xsl:choose>
            <xsl:when test="text()">
                <xsl:choose>
                    <xsl:when test="count(./preceding-sibling::text()) >= 0"/>
                </xsl:choose>
            </xsl:when>
            <xsl:when test="name(.) = 'page'"/>
            <xsl:otherwise>
                <xsl:choose>
                    <xsl:when
                        test="count(preceding-sibling::text()) = 0 and count(following-sibling::text()) = 0"/>
                    <xsl:when
                        test="count(preceding-sibling::text()) = 0 and count(following-sibling::text()) > 1">
                        <xsl:value-of select="concat('[', '1', ']')"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of
                            select="concat('[', count(preceding-sibling::text()) + 1, ']')"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <!--RC-161 Date 11 Nov 2017 by Surendra-->
    <xsl:variable name="vUnits">
        <units>
            <unit name="in">96</unit>
        </units>
    </xsl:variable>
    <xsl:template name="ConvToPixel">
        <xsl:param name="colwidth"/>
        <xsl:variable name="vQuantity"
            select="substring($colwidth, 1, string-length($colwidth) - 2)"/>
        <xsl:variable name="vUnit" select="substring($colwidth, string-length($colwidth) - 1)"/>

        <xsl:value-of select="floor($vQuantity * exsl:node-set($vUnits)//unit[@name = $vUnit])"/>

        <!--        <xsl:value-of
            select="concat('width:', floor($vQuantity * exsl:node-set($vUnits)//unit[@name = $vUnit]), ';')"
        />-->
    </xsl:template>
    <!--End-->
    <xsl:template name="getcolwidth">
        <xsl:param name="allcol"/>
        <xsl:param name="naMend"/>
        <xsl:param name="naMest"/>
        <xsl:param name="allCols"/>
        <xsl:param name="precCols"/>
        <xsl:if test="$naMest = $naMend and $naMest != ''">
            <xsl:call-template name="ConvToPixel">
                <xsl:with-param name="colwidth"
                    select="exsl:node-set($allcol)[@colname = $naMest]/@colwidth"/>
            </xsl:call-template>

        </xsl:if>
        <xsl:if test="$naMest != $naMend">

            <xsl:variable name="posStart">
                <position>
                    <xsl:for-each select="exsl:node-set($allcol)">

                        <xsl:choose>
                            <xsl:when test="@colname = $naMest">
                                <posT>
                                    <xsl:value-of select="position()"/>
                                </posT>
                            </xsl:when>
                            <xsl:otherwise>
                                <posF>
                                    <xsl:value-of select="position()"/>
                                </posF>
                            </xsl:otherwise>
                        </xsl:choose>

                    </xsl:for-each>
                </position>
            </xsl:variable>
            <xsl:variable name="posEnd">
                <position>
                    <xsl:for-each select="exsl:node-set($allcol)">
                        <xsl:choose>
                            <xsl:when test="@colname = $naMend">
                                <posT>
                                    <xsl:value-of select="position()"/>
                                </posT>
                            </xsl:when>
                            <xsl:otherwise>
                                <posF>
                                    <xsl:value-of select="position()"/>
                                </posF>
                            </xsl:otherwise>
                        </xsl:choose>


                    </xsl:for-each>
                </position>
            </xsl:variable>
            <xsl:variable name="RelCol"
                select="exsl:node-set($allcol)[position() &gt;= number(exsl:node-set($posStart)//posT[1]) and position() &lt;= number(exsl:node-set($posEnd)//posT[1])]"/>
            <xsl:variable name="totalWidth">
                <data>

                    <xsl:for-each select="exsl:node-set($RelCol)">
                        <number>
                            <xsl:value-of
                                select="substring(@colwidth, 1, string-length(@colwidth) - 2)"/>
                        </number>
                    </xsl:for-each>
                </data>
            </xsl:variable>
            <xsl:call-template name="ConvToPixel">
                <xsl:with-param name="colwidth"
                    select="concat(sum(exsl:node-set($totalWidth)//number), 'in')"/>
            </xsl:call-template>
        </xsl:if>

        <xsl:if test="$naMest = ''">
            <xsl:variable name="widthNode">
                <root>
                    <xsl:for-each select="exsl:node-set($precCols)">

                        <xsl:choose>
                            <xsl:when test="./@namest and ./@nameend">
                                <width>
                                    <xsl:value-of
                                        select="ext:GetColSpanValue($allCols, @namest, @nameend)"/>
                                </width>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="'1'"/>
                            </xsl:otherwise>
                        </xsl:choose>

                    </xsl:for-each>
                </root>
            </xsl:variable>
            <xsl:variable name="posEntry" select="sum(exsl:node-set($widthNode)//width) + 1"/>
            <xsl:call-template name="ConvToPixel">
                <xsl:with-param name="colwidth" select="exsl:node-set($allcol)[$posEntry]"/>
            </xsl:call-template>
        </xsl:if>
    </xsl:template>
</xsl:stylesheet>
